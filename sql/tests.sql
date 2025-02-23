select resources.title, users.name, signatures.role_id
 from resources
 inner join signatures on resources.id = signatures.resource_id,
            users on users.id = signatures.user_id
 where resources.category = 'book';

select resources.title, recommendations.at, users.name
 from resources
 inner join recommendations on (resources.id = recommendations.resource_id),
     users on (recommendations.disciple_id = users.id)
 order by recommendations.at;

.headers on
.mode column

select resources.title, advocates.name as advocate, disciples.name as disciple, recommendations.at
 from resources
 inner join recommendations on (recommendations.resource_id = resources.id),
    users as advocates on (recommendations.advocate_id = advocates.id),
    users as disciples on (recommendations.disciple_id = disciples.id)
 order by recommendations.at;

