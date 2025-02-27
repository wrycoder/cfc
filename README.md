## Center for Congregations demo

This repository contains SQL code for the **third** in a series of projects
for the Center for Congregations. There are two scripts, and they're both in the
`sql` directory.

The assignment was to create a simulated clearinghouse for resources used by
congregations in Indiana. Each resource is associated with an author or promoter
(advocate), and resources can be recommended to users. Recommendations are tracked
by date, recipient, and recommender. Recipients and recommenders are known,
respectively, as `disciples` and `advocates`.

In this design, an `advocate` usually has a dual role: it recommends a `resource` to
multiple `disciples`, but it also may be either an author of, or advocate for,
a specific `resource`. To support that capability, a user can be connected
to a `resource` through a `signature`.

![entity relationship diagram](https://github.com/wrycoder/cfc/blob/main/erd.png "Entity Relationship Diagram")

Although I tried to be as platform-agnostic as possible, I didn't have access to
a SQL Server platform. The scripts would need **at least one** modification to
run on that system. Change the following line in each `CREATE TABLE` statement:

     `ID        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,`

  ... to the following:

     `ID        INT NOT NULL PRIMARY KEY IDENTITY(1,1),`

The other two projects in my submission to the Center for Congregations will
be provided separately.
