Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022183B388A;
	Thu, 12 Mar 2026 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773357222; cv=fail; b=rWHb40Sea2hT+J3sYwUgwXQ138WtXVyIVBKjNBc3R0YCu9XaKixx4OdjizMv2MF2OD7C0EnU+ucAV0IAhdcoE7gbnjcmw/gScD6Rv3V8NpxKkMgCK6oZEpjcGlbHvIJZm0H/N4KhsRa5novRMzrAzBKsTRXWBm9+HVoHa4Qfc8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773357222; c=relaxed/simple;
	bh=i9BUkKj8IhTHGX3QjLhTQ4RI5Wf2Bm2RNstL3YJlBa0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RQhCgE3DUiqYk1SSe/R680jWUxV4j5jcZXgq5TtUZsyOBrGQ9FDQYMvBAkQqWsinxDeNeQOt64f0cbAW5bn2cvvkmTSHKuuuhqRhKAyZg5kx2fy/iSHeVsdxhIis3JNizxrre+OwFnrLciDrRs/OWiOns13PeKWj6+XMkz63nvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N9lFqwqC; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N9lFqwqC"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CEW91Y2303563;
	Thu, 12 Mar 2026 23:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=i9BUkKj8IhTHGX3QjLhTQ4RI5Wf2Bm2RNstL3YJlBa0=; b=N9lFqwqC
	BzmFWmME2OltW7gH9W89zeaJTa/SLAfnPYV/8s9PbI2cOTH7mc3IxxRQbauKroEp
	rkfSp7f5ARloX0pIuukg94zaFyHl7CFjhgHY9oncgMQpa8LlJqZSVra9ygbr/5pZ
	oDJTXqQcaWHctiYsMRCrHpBNvqlq4sqBqIGPW6duoNOGKSHTU21DdcehfHFwBjQe
	HzuvKx6P2XCE8LTA1u7AG/60VltTXBx5QAHNbrneJoXadQnMgI5U+5ZrWnmCm9wL
	N+R6LLOmDsQQaf2d9LR6W8Bwm8RrcgD0BUI6CW+kOmfM85njDl8aJIt1Lk2bj9ZL
	ybBhyDJCcDBx4A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95w1jf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 23:13:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE771Cf1sGvnOtm6K0D/cvPkicWdMMJwxLViEqIGp6iXX3Gh/ivQgRPG9lxdwYv2m/OzPANv/hqWcNfCFLyzkQHaFhUMwRpDLtvG9Ck1yU5usNwqL6tYYotfvdCP2ND+9TMmW4hP5ZB7Jr7u4KybiWdJXnKoqII9SfIJx/zOfzDqN2GZrzNJJ+D+yTRmvJs+U81pFT3GERBGOHJYdLqDYZFRo8CRfe95uCoKQcS56yiyE1pPE/hTQw586qXHm9Q5CjR5AuwZY+B6SmyWHziXznVkmBmPhDeaKvjiDx+b5nzR9rYjEuRhgh/xYszN/PIOWOikU2VcoOvogs9mscuQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9BUkKj8IhTHGX3QjLhTQ4RI5Wf2Bm2RNstL3YJlBa0=;
 b=VeS9+Jd3lCNvmrzSN+9WpsMFz9VFqGTfoNjUheNYSeHADit84RfmWF0Z3LlRLaU2Bn4HeG5HtnfMVN2wEFVgv5TLlqQtbfC9x9xTdz4vH24DM2ejluZ/Iko5n+pPSiYolIJlo3O6u69xeXutv8cYzsBYuqQoELW6G9XcZZgJc5AiXWtrnNwdqtMn+e+elLfPJnml9aFyBfsjtojHGCc8MLRMQZB6t+Hx4abZPN5VUnHhNZcigDsR9OYVIfUVdb8NJ0xRa8/b99xOylBNzUEyqP+jX4YL+pND2747SJxfTp/BY1G6Wz5lEqzZTRGvQ7zyaqjGRI435aJQMoVSnTC1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4230.namprd15.prod.outlook.com (2603:10b6:510:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 12 Mar
 2026 23:13:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 23:13:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Thread-Index: AQHcsg/APN5tsWR8/06I9Ew1VYcR+rWrh4IA
Date: Thu, 12 Mar 2026 23:13:21 +0000
Message-ID: <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
References: <20260311211309.27856-1-contact@gvernon.com>
	 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
In-Reply-To: <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4230:EE_
x-ms-office365-filtering-correlation-id: 859a1c75-10e0-4e19-9eb9-08de808cf477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 +3gg1c96UgMDeV4eYnTTxauGWTh/xzJzWrvhcyGMNl9KIWDgjMw35RshOWsDTIWvtWP+Us0yJDc/Lc86Gt3eZgjrN8IQGgSFruGDxfvhn1J14YPOtvlHBsACmOKCGse8/PWht4eSakq/7z7WmMr69T/Zoe1m4UQ5WcEHwU4bJ+5cXvUYxVjZDc15qneHggHbdUXr6QDYDQsxMHL4grGmxRj/2p2AhWoM4TkNhVzYepgXydql2XSiPTKhwTYEG/LDhFz2o6PIdNeemDk9alfvX3qy0+GDjkNelYsyLhtajM0S7vdzoXRKIw0vNgpkoImEda6khm2QrvxJjl+dyfA/rcvf85GfP6L/VAqHC8t7T5Iioo+HnICeYocJXPKW0gLLIqZbHTNCrCZmddk55hgulUX1sYVgx2Uzbrio2eabW9kWbHT0dGx69ABXGCKPfKDSrR5dkN74EiX62YpkFaDupdWYOz28HxesBJ/8bOcUenho5oysxzIm1ey7oQO/lBdVyXK9E1FLMJqhbxv8IcABA3y/Xz4NbEAa/BKvqmTuvXxWcSBGwjSvFDtfwYP1ZDyF1ZTmjB9BMcmSkuKxZc6/Y/FhRleWfbbQBG7poDNYcgYXUkyuDiXdbx9o6VSTUHvLxlOvkyfJy/1sbSxI3SgdbCEuhvSrOEx3nkQzi3gHQLVyCKnrcGyRGOxlM2kKAVufIOQblHMqC1QNGoUupWp2Sfa9Dq+ggYPdEezEGK+tQWF7k4CCm7aJV9zHx41gkMuH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2xtdENlZGlDYTcyT2FDNlVPUkZ4WTVYZ0d6cE1waTgyYlVVQzh3eER3Z3pV?=
 =?utf-8?B?ZXFyNzZCZHZDRFdZOG9DNEVZOVg1N2hDdGk1STFQeko3c2R2b1RYN00vS1ZK?=
 =?utf-8?B?R21LQjFOSElJMm1SUUlROGRFRk5EQlVlL1RoN0t2YWVxeWVEbEVwSEsvYUFP?=
 =?utf-8?B?TWxmQzhCNHZicDhLbDFUL05OMEhLZ1BocmdmRi9ZazYybTVqRHZ4dzZPbFU4?=
 =?utf-8?B?Z21ZL0g3MHZSL2lSWm9mSm40M3UwVEN6VWJiWWdyUHNvMmgzWTI5MHM3amds?=
 =?utf-8?B?SFBVSVgvd0w3MEZ6VWlJVDdtYTFwaDhUcFYzVTNGV3d5OW8xN3lQOEpocjA1?=
 =?utf-8?B?UlFkOTJBalBGd3NkMEwxVHZHbnovRVBVc2hodkViNGswajdJRi9lSzBHNFg0?=
 =?utf-8?B?SWF2Sk1Pd3diNXpPbHNpNXc1c1cvRUNjQjVsQnR0eGJSN0VneVB2UzRUNlhr?=
 =?utf-8?B?bHhjVkZMbDllS1BFbkY1TG5MR0pBb1duQTd4Mi8rNGM3b08vK1NBWlpVQWJO?=
 =?utf-8?B?REhGN3VlTUQ5TnNvQjQwSW03UHFLdnJNYTZRNWM2VEZXNi9HOUMwQVlWTmVt?=
 =?utf-8?B?WmIxdkpiOUpSUnRjZ2szWWhibytJcDZhSzdXNmpPb2NheUU5eU1uK1IxeWFQ?=
 =?utf-8?B?VlVXa1Y5YXpYY3VQSkw3cnhTY3V0WGJrOG9aN0oxYWQrMEs2SjBLNWtMbG5S?=
 =?utf-8?B?c1NFVmhoRFFEU0V5VFBtWUxUWWpyTzAwN3FRSTB2SGNDUHE2cXhrcjRSWm1K?=
 =?utf-8?B?d3BEWVU4WlptbFBMSlZQbmIvVVU1Y1luYXNKSEh1SjZqOFBRbW1qNC80bkho?=
 =?utf-8?B?djNvL2hqVVBtZ3JzSzlVcjhDK0xuZ2FsREFCc2FWWWZKTGtaZnltcmpaQXpi?=
 =?utf-8?B?NjZnWnhreWpKTW1xQVkvVHdId1htRHZ5Qm1ycDFxWlRQM3Btckt4S0prckxk?=
 =?utf-8?B?cFZwcFJVRDdRbkpYQnExVnVXNjluelExaStsSkhXb1JVOEhqb3NoZ2lRK2dx?=
 =?utf-8?B?ZVVPOWR1YVVlQnR2NXJXUnhnS0d6NFgrVUk2UzFZS0I3dlpVVnljZ2hMa3J5?=
 =?utf-8?B?SFhuNnZHa2dxQkdpRTVUVkgxeGsvTXFWbkZqUTZLRFNPYi85c0NHRWxPOThE?=
 =?utf-8?B?N1p6bFd5VG03eERFVzJUdit1MVNXMEVjWVFveFR0UkxlbHg3VVQzaHpwVnhR?=
 =?utf-8?B?MDE4cGZ5cG85RFdHWWxXd1hzb2dXc09CSTZIOXVVUTc0b0ZCTTAyeTNiMTNY?=
 =?utf-8?B?bE9jd1VFT05DV0lLd1llZ1lmcTVIZDZ4N2NzMCtPN3Qyb3JIOU52UXIzbkd5?=
 =?utf-8?B?Vjd6T0hLa1NEZmFkRHpaQjUxanFOcFEvckZWeDZZeHhNckE3Z05OVndaZDZw?=
 =?utf-8?B?NlJhZkZCSWN5cWxqQU4xQjkzcm9SWGMvMHlxK3AyZk9ncCt6UFRva1N0RVpl?=
 =?utf-8?B?TzZrZTJzWHUrRmY1ZzJuNkdkQ0xkM25vYzdBQkNsOU9FZ0lVdU12ZTdUUHUy?=
 =?utf-8?B?WldCZnFPZzdzVWtkbTBQUUd3cTRYb3RMQWJHeU5PU1V4SE9ZZS96S254RE9q?=
 =?utf-8?B?dEFlWkNHUjFTMGRlWEtYalQydDZwNWFhRjAwR2F1WjJyY3V3WEl0dHhZRG9E?=
 =?utf-8?B?NTJhWUVhRVVGZGNjdkx5V0JaeWxlSkVnQmpGaS9SYnl0cEw1MjZLVTBYMCty?=
 =?utf-8?B?dnhabTlHeEJ0cUVaYnB2R3NlWjRVZ04yN0d0RHlWWTlwelRhWkNSTVIyemJP?=
 =?utf-8?B?RS9HWjNGSVhiQWRsY3V4NzY5cm9aTlBCL25pNThrSjluQlIvTnBMNTlHWFoy?=
 =?utf-8?B?NnQybm00NDFMWWpEODFwTkFjUjQyb0p0ZXlpK1p6VW5weEFnWUttMThyRmhk?=
 =?utf-8?B?aUlObStIQmJZZGFtQUY0YjBwY0kwYnpjaUVzVnc2RUZlb3dSV0VFYlpTRmR5?=
 =?utf-8?B?T0lxRThJdUVrQlU1L3p3eHY0bmVSYld1V0htbE8xcHlUenhuWW93bkErOERL?=
 =?utf-8?B?L3VHcVFIeXEvZmU4ckdNNXYvRm5VcGFqdGZxN2Jld3RzSFVhT1NFdGhuS0NM?=
 =?utf-8?B?bXpVWWJTZVpCVWNvODlLWkJUWDcwWFN5ODdJUW1kdzkyMzE3YlRyTUxkczlq?=
 =?utf-8?B?VXdrTzNqc2ZXUmhWTEVlYndTMzFOZVNaTk1JUE1uWEJETHl5cDJ4ZytzcjJj?=
 =?utf-8?B?ajlBVTZjTFQ5Y0xkYmZoQ2FwdCtOck1kMWcyWGJJQ2IzbDg0cU10cnRGbm1G?=
 =?utf-8?B?ZmFEL1FMWXVpWjBrckFrQmdMS1h0Q0Q4bFFIeWhnUis5T25UNDFjNEZvMUo1?=
 =?utf-8?B?a292dlh1QjRIL3FmZSt0Ym5kRnJROEI1WTN6eUEyeXJ3R2NwZ0U3ZCtiNjBY?=
 =?utf-8?Q?IuwOsA+m432HzZh/15F6NM4Lw94wxb2YzzE28?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67DAB5CBACF4AC4EBDF4AD8C5EB93FE2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hbsr8kek2k7TtUZadwqsrKE9h76DcnueH49LO/nTBBf/qg+h9OJaA/3LKAOCPr1HY/m/YA5ois8G7dIuLAW3jA3FJHp8e3Gg7eofa6qhFFk5yBkrcV7Yage2VMlX6m+BPTsPv5O/E3UohMBNmfUHmZ3d8iqN+nbsHpmtNVMkv0QYT/vQu1f3tGaPudHnRqz3EhkITd1nBgGdG3nKILTRr1aadn69Bcv5qp1c9ZKNpfmzDuLt/tDpza6S98VWwOJynGOd9OSPFYWdwXXAX+v7YWO7sW4MZFDZFMSlcVuMWFxXJFQlohlA4y0AGBpMATPiFUmkylgiu9ST0kYG0qxeZw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a1c75-10e0-4e19-9eb9-08de808cf477
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 23:13:21.4456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iITif+jD+xvQt4IhBCeoS/KxVbofaGntcBTjXdexbgQ7NxVI1Qmlzx6q1Z9QqkiAN15u9/EhPk480uZoFn/NoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4230
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE4NSBTYWx0ZWRfX71LZmusCY0D0
 ShWUKyICWWN4Wn8C9n4zdzHB30K4OWhr1IBaY08tJeFyqjj0aNsmANJQF5xvFsvQXnSTJqvKmT4
 vlunoMpiMQR7TdOnlqgJof60/F9Q5V0VwW3f92RiW3M13z1N6YzCBOBjw2HTMceKQAzn4M3XaED
 E5g4/udXDEMk4PguMY6YySL6cCsaqUnXFAc6JiT4B3Bn8pwrh4cV/tZPXW9da+LRd9zkIXw/5wx
 XyCzCFG1PgMIcCez8PCnhrLm0QhVd6jC5wniccXMNxRU7iZ2S2Gi4HsCYy465Oq64LCNS3D2JFU
 6J7wHlx+/IUddYhuR4NhgrsEfaMnBl1ltZmGcRno1tM8NAUqQMBWpbPPtO/Us7Sa15C+NsiZjUD
 9RnWC9JlH01oR40l/lWy9Q+xUkxNYKSVyY6SWGrPKOiJv1r9UIo1N57PWQqwlZ1qgFNeksJH4aw
 fnEgH4R+rnR7Stsmp+w==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b34894 cx=c_pps
 a=1XVf1DeqYCuQPrRRBBNiYg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8
 a=vyu0NfzEUGqUx_YyVnAA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: ZQu_MaA9BcINbkP6xdnU92vKtF9pCG7c
X-Proofpoint-ORIG-GUID: ZQu_MaA9BcINbkP6xdnU92vKtF9pCG7c
Subject: RE: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120185

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDE5OjQ1ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IFNpbmNlIGlzX3ZhbGlkX2NhdGFsb2dfcmVjb3JkKCkgaXMgY2FsbGVkIGJlZm9yZSBpbm9kZS0+
aV9pbm8gaXMgYXNzaWduZWQsDQo+IA0KPiArICAgICAgICAgICAgICAgcHJfd2FybigiSW52YWxp
ZCBpbm9kZSB3aXRoIGNuaWQgJWx1XG4iLCBpbm9kZS0+aV9pbm8pOw0KPiANCj4gYWx3YXlzIHBy
aW50cyAwLg0KDQpZZWFoLCBleGFjdGx5Lg0KDQo+IA0KPiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4gcmVwb3J0ZWQgdGhhdCB0aGlzIHBhdGNoIG5lZWRzIGJlbG93IGNoYW5nZS4N
Cj4gDQo+IC0gICAgICAgICAgICAgICBpZiAoIWlzX3ZhbGlkX2NhdGFsb2dfcmVjb3JkKHJlYy0+
ZmlsZS5GbE51bSwgcmVjLT50eXBlKSkNCj4gKyAgICAgICAgICAgICAgIGlmICghaXNfdmFsaWRf
Y2F0YWxvZ19yZWNvcmQoYmUzMl90b19jcHUocmVjLT5maWxlLkZsTnVtKSwgcmVjLT50eXBlKSkN
Cj4gDQo+IC0gICAgICAgICAgICAgICBpZiAoIWlzX3ZhbGlkX2NhdGFsb2dfcmVjb3JkKHJlYy0+
ZGlyLkRpcklELCByZWMtPnR5cGUpKQ0KPiArICAgICAgICAgICAgICAgaWYgKCFpc192YWxpZF9j
YXRhbG9nX3JlY29yZChiZTMyX3RvX2NwdShyZWMtPmRpci5EaXJJRCksIHJlYy0+dHlwZSkpDQo+
IA0KPiBCZWNhdXNlIG9mIHRoaXMgZW5kaWFuIGJ1Zywgc3l6Ym90IGRpZCBub3QgdGVzdCBpc192
YWxpZF9jYXRhbG9nX3JlY29yZCgpID09IGZhbHNlIGNhc2UuDQoNClllcywgeW91IGFyZSByaWdo
dCBoZXJlLg0KDQo+IA0KPiBUaGlzIHBhdGNoIGFsc28gbmVlZHMgYmVsb3cgY2hhbmdlLg0KPiAN
Cj4gLSAgICAgICBpZiAoIXJvb3RfaW5vZGUgfHwgaXNfYmFkX2lub2RlKHJvb3RfaW5vZGUpKQ0K
PiArICAgICAgIGlmICghcm9vdF9pbm9kZSkNCj4gICAgICAgICAgICAgICAgIGdvdG8gYmFpbF9u
b19yb290Ow0KPiArICAgICAgIGlmIChpc19iYWRfaW5vZGUocm9vdF9pbm9kZSkpIHsNCj4gKyAg
ICAgICAgICAgICAgIGlwdXQocm9vdF9pbm9kZSk7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGJh
aWxfbm9fcm9vdDsNCj4gKyAgICAgICB9DQoNClllcywgaXQncyBnb29kIGltcHJvdmVtZW50Lg0K
DQo+IA0KPiBTaW5jZSB0aGlzIGJ1ZyBpcyByZXBvcnRlZCB3aGVuICJybW1vZCBoZnMiIGlzIGRv
bmUsIHN5emJvdCB3b3VsZCBub3QgYmUNCj4gYWJsZSB0byBmaW5kIHRoaXMgYnVnLg0KPiANCj4g
QW5kIGV2ZW4gYWZ0ZXIgYm90aCBjaGFuZ2VzIGFyZSBhcHBsaWVkLCBteSBwYXRjaCBzdGlsbCBt
YWtlcyBzZW5zZQ0KPiBiZWNhdXNlIG1vdW50KCkgb3BlcmF0aW9uIHN0aWxsIHN1Y2NlZWRzIGZv
ciBjbmlkID49IDE2LiA6LSkNCg0KSSBkb24ndCBmb2xsb3cgaG93IGl0IGNvdWxkIGhhcHBlbi4g
UGxlYXNlLCB0YWtlIGEgbG9vayBoZXJlIFsxXToNCg0KCS8qIHRyeSB0byBnZXQgdGhlIHJvb3Qg
aW5vZGUgKi8NCglyZXMgPSBoZnNfZmluZF9pbml0KEhGU19TQihzYiktPmNhdF90cmVlLCAmZmQp
Ow0KCWlmIChyZXMpDQoJCWdvdG8gYmFpbF9ub19yb290Ow0KCXJlcyA9IGhmc19jYXRfZmluZF9i
cmVjKHNiLCBIRlNfUk9PVF9DTklELCAmZmQpOw0KCWlmICghcmVzKSB7DQoJCWlmIChmZC5lbnRy
eWxlbmd0aCAhPSBzaXplb2YocmVjLmRpcikpIHsNCgkJCXJlcyA9ICAtRUlPOw0KCQkJZ290byBi
YWlsX2hmc19maW5kOw0KCQl9DQoJCWhmc19ibm9kZV9yZWFkKGZkLmJub2RlLCAmcmVjLCBmZC5l
bnRyeW9mZnNldCwgZmQuZW50cnlsZW5ndGgpOw0KCQlpZiAocmVjLnR5cGUgIT0gSEZTX0NEUl9E
SVIpDQoJCQlyZXMgPSAtRUlPOw0KCX0NCglpZiAocmVzKQ0KCQlnb3RvIGJhaWxfaGZzX2ZpbmQ7
DQoJcmVzID0gLUVJTlZBTDsNCglyb290X2lub2RlID0gaGZzX2lnZXQoc2IsICZmZC5zZWFyY2hf
a2V5LT5jYXQsICZyZWMpOw0KCWhmc19maW5kX2V4aXQoJmZkKTsNCglpZiAoIXJvb3RfaW5vZGUp
DQoJCWdvdG8gYmFpbF9ub19yb290Ow0KDQpXZSByZXF1ZXN0IHRvIGZpbmQgZXhhY3RseSBIRlNf
Uk9PVF9DTklELiBJZiByb290IGZvbGRlciBoYXMgYW5vdGhlciBDTklELCB0aGVuDQp3ZSBzaW1w
bHkgY2Fubm90IGZpbmQgdGhlIHJlY29yZCBmb3Igcm9vdCBmb2xkZXIgaW4gQ2F0YWxvZyBGaWxl
LiBTbywgd2UgbmV2ZXINCndpbGwgY2FsbCBoZnNfaWdldCgpIGlmIHdlIGNhbm5vdCBmaW5kIHRo
ZSByZWNvcmQuDQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjYuMTkvc291cmNlL2ZzL2hmcy9zdXBlci5jI0wzNTANCg==
