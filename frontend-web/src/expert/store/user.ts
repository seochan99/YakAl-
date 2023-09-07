import { ESex } from "../type/sex.ts";

export type TUser = {
  id: number;
  name: string;
  sex: ESex;
  birthday: Date;
  testProgress: number;
  submitDate: Date;
};

export type TSpecialNote = {
  id: number;
  title: string;
  description: string;
  recorded_at: Date;
};

export const users: TUser[] = [
  {
    id: 1,
    name: "홍길동1",
    sex: ESex.MALE,
    birthday: new Date("2000-12-13"),
    testProgress: 30,
    submitDate: new Date("2023-07-13"),
  },
  {
    id: 2,
    name: "홍길동2",
    sex: ESex.FEMALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2023-07-13"),
  },
  {
    id: 3,
    name: "홍길동3",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2023-07-13"),
  },
  {
    id: 4,
    name: "홍길동4",
    sex: ESex.MALE,

    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2023-03-13"),
  },
  {
    id: 5,
    name: "홍길동5",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2023-01-13"),
  },
  {
    id: 6,
    name: "홍길동6",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2021-12-13"),
  },
  {
    id: 7,
    name: "홍길동7",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2000-12-13"),
  },
  {
    id: 8,
    name: "홍길동8",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2000-12-13"),
  },
  {
    id: 9,
    name: "홍길동9",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2000-12-13"),
  },
  {
    id: 10,
    name: "홍길동10",
    sex: ESex.MALE,
    birthday: new Date("2000-02-13"),
    testProgress: 30,
    submitDate: new Date("2000-12-13"),
  },
  {
    id: 11,
    name: "홍길동11",
    sex: ESex.FEMALE,
    birthday: new Date("1998-02-13"),
    testProgress: 82,
    submitDate: new Date("2000-12-13"),
  },
];
