.headers off
select "";
select "";
select "";
select "RESOURCES";
select "";
.headers on
.mode column
select resources.title, resources.category,
        users.name as 'interested party',
        roles.label as 'role'
 from resources
 inner join signatures on resources.id = signatures.resource_id,
            users on users.id = signatures.user_id,
            roles on signatures.role_id = roles.id;
.headers off
select "";
select "";
select "";
select "TAGS";
select "";
.headers on
.mode column
select resources.title, tagcategories.label
 from resources
 inner join tags on (tags.resource_id = resources.id),
      tagcategories on (tags.category_id = tagcategories.id);
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

