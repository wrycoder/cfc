.headers off
select "";
select "";
select "";
select "BOOK AUTHORS";
select "";
.headers on
.mode column
select resources.title, users.name, signatures.role_id
 from resources
 inner join signatures on resources.id = signatures.resource_id,
            users on users.id = signatures.user_id
 where resources.category = 'book';

.headers off
select "";
select "";
select "";
select "WEBSITE PROMOTERS";
select "";
.headers on
.mode column
select resources.title, users.name, signatures.role_id
 from resources
 inner join signatures on resources.id = signatures.resource_id,
            users on users.id = signatures.user_id
 where resources.category = 'website';

.headers off
select "";
select "";
select "";
select "BUSINESS PROMOTERS";
select "";
.headers on
.mode column
select resources.title, users.name, signatures.role_id
 from resources
 inner join signatures on resources.id = signatures.resource_id,
            users on users.id = signatures.user_id
 where resources.category = 'business';

.headers off
select "";
select "";
select "";
select "RECOMMENDATION HISTORY REPORT";
select "";
.headers on
.mode column
select resources.title, advocates.name as advocate, disciples.name as disciple, recommendations.at
 from resources
 inner join recommendations on (recommendations.resource_id = resources.id),
    users as advocates on (recommendations.advocate_id = advocates.id),
    users as disciples on (recommendations.disciple_id = disciples.id)
 order by recommendations.at;

