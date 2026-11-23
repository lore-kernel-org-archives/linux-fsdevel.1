Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795464068;
	b=AqUKxDSNDudMuhT0MXBIqpy0SG2cmjc/5zJ244fl9YLAtt+/NSGIIvPMsg7B+MBXdERv
	 l6IMPlcQxWtEFp17Y9jvQ2a73Xy/vZkCbB25noqDYzWX0+FeTgBEOQ6kOIF5o60ZjM3cp
	 Tm2H6NQdjb1KUvx+K55QAFc/M62cmEfm8x7a14/40Ll7a7McXnyd6UGM4SEbGLq6s2HPv
	 hqdKCWNfde0CFnGkyUSTx4aUYyLdl/Fd3dEPHzLEX9LcDQDumBRKCmWS0NQARg5S6mXP6
	 vqsUSYheWHRFtfz+/Uoe7DZ314zhkr3XlOYFHW0FXXm41L1dKsq/+beNA/aICnE8VmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464068;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TpkK+B/5zyEyi1NA3ifqYhtCSnPDEN7yi7PPjRJFfbU=;
	b=xibokKuc/ruYCQrNLzbKUAxsk39SUCwaMbusc0TUvFv0Y4DYY5T0rtjurH0otfl105y3
	 4+2XF4rKBQI9I0ccoX3v6YrQPcPeC0mJVd/02Qbxs9UAF5V1LlQ+L9ebmETrbLmkHk/SO
	 sQBC8ggwCWPYzWorQJU92tp4xkNpqH7W7R3TuDBX7ANUVZVqxvNZOamQVqyrn6gLYeKY3
	 qvgFwtiloBOujWAwWdwfz0lvu803FP59y7TpAFQH0hudJ8Pg2gSKT7mv+qZqtxt2sFYUj
	 M0Oxj0/CqLrb4pvXB0jotkGB/Kh9N8yZu37nZMFuAngJzZFzMIWkwRVJG37nq/agjLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JrX89QKZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.26
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010026.outbound.protection.outlook.com [52.103.23.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93873606A31E;
	Mon, 23 Nov 2026 20:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93873606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JrX89QKZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTyka9dwtOrcWJrQW4tV7DOMrJh/2ZY/toE7tshFJSvPE1sGEIf1px3molqKKrtVCWDhpajutyf+HhRUyf7zWTJJmgvldS3EIB2FJr2UccviApDdS58J055gW02r5PdeeHOYRncpUhu0XF9k4XoQUnw6BrrS9cBPlrl20/hMHZjQwlKTn+xOWZzBmhV1rQHnZ7MjsY0dSo6qDyWyq19/XcGZHG1WtWefja1mTphoevdAq0HpDYmoG6SzpjLp4swYEsQR7VWiXiGxSgG+Zu5yamADG9zHLOAG36jV1Gk8raXdzi7mZpZEbCFF2LQBkqrbqjc/W2YfTSraMYYc45bADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpkK+B/5zyEyi1NA3ifqYhtCSnPDEN7yi7PPjRJFfbU=;
 b=e8oGMBN0doTXYRkG99axlr4gQ+6wSBY6uM/VM8y686gclhR8VzXK36c+QsnDrgK8fxx0RkbRclu2mek6LP7VSVQ9rmXsqkCjueMxg3JiGcZxccKqC14ZFy186N5+ZeNhmPbcnzgmXq3RHsTlbyh0sZtUrcmgjaFrdpYaZ3AKyqLzqrWw4BQogAtg4rTacgwuZnQgfeagz8/u/BbRfKMUoXrAKis6QTFa/cvcWzq18FblPfCG3lwNiCXx5Wk8oZcILkTH8zibWOvtq3K5xPHtGSkCCvsb68UMYZbO9+FHSXjUKWhFLCu/OiYzRQ23qs/d3f857ja5YYTOttN8kcMn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpkK+B/5zyEyi1NA3ifqYhtCSnPDEN7yi7PPjRJFfbU=;
 b=JrX89QKZOBPav8V6I89WAbyxirvCKztyK4bfGeu78p99o17OJIUS2NSCEkL1SD2rnmaAD4C/wEBrkKV3BrfyL/FljkKwKvdxYOp1MhS8Wz0sq/Rfs4mPiZdHwvo5TZB3ivNIjMUZ6FUakdsTO9Ikzln8YBztprNzPuJ/pxQIq0NG6wV3SWmKkizKJ0ZriK0EYDO3XlzbzMAXcSOI3mFdPZWdCNfZf3umEkwLWxofmbrnQ3ZRo1CBVInwr2StiW/m3MwwUgifwHjuGyttZJF7og11HjG0tZ3d+K63eQ33kSwXo+I+WCvxgsBNLa2d943z6GlSRRtpmx9WeShMys5FgQ==
Received: from DM4PR15MB6276.namprd15.prod.outlook.com (2603:10b6:8:185::22)
 by PH0PR15MB4637.namprd15.prod.outlook.com (2603:10b6:510:89::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 20:01:04 +0000
Received: from DM4PR15MB6276.namprd15.prod.outlook.com
 ([fe80::cfd2:b16d:7d13:943f]) by DM4PR15MB6276.namprd15.prod.outlook.com
 ([fe80::cfd2:b16d:7d13:943f%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 20:01:04 +0000
From: theBIT5 x3zk <x3zk@outlook.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ntfs: deleting $Extend breaks subsequent mount
Thread-Topic: ntfs: deleting $Extend breaks subsequent mount
Thread-Index: AQHde4R8xv4yfu0CbUa8W2Kg8yjy6g==
Date: Mon, 23 Nov 2026 20:01:04 +0000
Message-ID:
 <DM4PR15MB6276A5C442568B4C7E604AA386452@DM4PR15MB6276.namprd15.prod.outlook.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR15MB6276:EE_|PH0PR15MB4637:EE_
x-ms-office365-filtering-correlation-id: 478f34aa-14ff-406e-9b47-08df499c8166
x-ms-exchange-slblob-mailprops:
 5fu/r660v9Mj6U6kz+12O9pZy2TuKGHDKOloGPM4VKu8Yhq50RGK/HGBR5z0RIUBcgTLWpfcf5zELr1+jVhQNZLKTK5YfLaBxkLj40Q0QUgCt0EqTTGQZPXmir78ekFJQHrySiM1IizLvmNeZyssGK426kAx0QOzIR40IKHm//5zlp9sMjpBnGrsS/lqvfEQfLCX/2zbPKfo42+nnN+NZOLA0z3c519bncUpcxRGc1K9oJPKgimBedbt4T3UQ0uIdyfEzkUIxWiVS4MfRk+nsvGN777H5zVuPBtuhPujEetNTNFcxDi487rqr2bvjJ38SS4pBVdD5sPXea4efYAF5KXXDwS3lvJ2RHZ1nh/BdQkCpq+jq1O8PN5q9M8An/k6sTRLYWtoIA8cmjaPj3bPloM27C2O0+Zu4tWMvfxAZ5B2zkhWrTR0HEQpIb8gy3oxDxzkfAKLYCZ3h2uod8QRcLMGdWsTD0XwhaSVJ1fWSsq80awcqVYf2qWuvrAMtYt5PRZGUVefe8M72JerP9Ed1Zf2sQ4lOj8qS0x2TcQIpFAezNWarj+ns1eqVjeylrJTsm2udMXEULhfsUx9+D6n1G1AeedeZ8ld1oqELiAT2w/eUGU7kAvCwLQrUzTKCGzzMJx2wvJkSAntT0XU2pxf5twkXBCriuZXahlhxTMqBUhmHHI67lgEZ8FwJxYg6WBQJs90zBRkC5tJip5VIZZpiQNXJ74osjsv8KbbGRf5FmI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|15080799012|15030799006|8062599012|20031999006|31061999003|24021099003|39105399006|6050399003|4140399003|3412199025|440099028|26104999009|102099032|3430499035|40105399003;
x-microsoft-antispam-message-info:
 =?koi8-r?Q?sn4fY86WZ+J82oqj6dvTDmWuyTrVJJVGXbIiu99QXgCjUhhJ+565BKVPhe5gNB?=
 =?koi8-r?Q?Y1ECbXpkEJo7NAb1mBkY526kFJI/6e4Z7tFUIt5N1auvqDjMGi/f/QH2xbbS55?=
 =?koi8-r?Q?TKc1XqXnC3deQsPP6/Hnu89Dq3Asapm0mbJFtFxVi0k4Q7c7lO5e1S/0e4kaZq?=
 =?koi8-r?Q?K17TxKqOoZOzqmzFqrSyl3lpZHNttXpFDD6hfKPg5zi7anra943VtLSQYnj575?=
 =?koi8-r?Q?Lo3nIFarx8ap7V76jSaDfq4gAKUye+K8AoeFFH2RmYI8i/0KGdXGC7y2NUt0wf?=
 =?koi8-r?Q?X2IU3jTEU0W3h9kAEt1Y/ipBc+lx9gzg1zxIyCRgNRNooo9SB2Xb4w5LAb9WkX?=
 =?koi8-r?Q?AK1ochMuyQ5y11qAaWEY1+y+w7nkDtWQjqfPME8ToMRJcZsD4DvkncEGiawSXF?=
 =?koi8-r?Q?LIiHc6ESK4NCvS3dXRyD66Y5YsYnKh+3N+iBZxqs1ednkv9PJs0/bkCpYv/ni6?=
 =?koi8-r?Q?rBI8DYaqK1XV/wdQAs2kqQDVHV4/sWEwWkqT0Y4rWf2+RolDqmqPsWr9/2QfTf?=
 =?koi8-r?Q?OGr/xqwrb6vn3+VLjYjF/fh/OpvP6j/DRI5eHeZ8OjBcU230XD9dTd78N7WYER?=
 =?koi8-r?Q?oMMx3TNxS3H5A9+3FXkzkvzQJXdD6AnEBzddtmIvaVh8hD+mr5b0mJEjTqB3kq?=
 =?koi8-r?Q?Z3+41yhLh73qRca2HsYctGpj+VI+EglDCV57YBhaw2BXnc6TgarXE0kyOrrM1R?=
 =?koi8-r?Q?5Kl9tNWPPSipCHGNoo7kup482eOQua50mMlYOTdaal4pyZ++f6DSDxqXTn99EI?=
 =?koi8-r?Q?vYSyCfYzb3odX4ueZafO+Ai4WAcWQj98TlDjgdnTSudreVIAbeCbSQl2XBh4+R?=
 =?koi8-r?Q?86dJrTY+zrrgzHwccHcrwdW7I870/p40CKwmoDWAZs1V0cuMOG0LBHGyX7zAjU?=
 =?koi8-r?Q?GLaHzB8mwSwfCgF8yBxz5KY9fDyDPsyWFoMff6RymtGBmID28VzURRWavndtz2?=
 =?koi8-r?Q?IijCTmDQkFWzvQdOeatRclftNSD/Pvss?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?ve9aGKqledcTSyIN0hSIYBB83WtVC6X3Ysk7jx2bsaZhlos2DGVwYyYebMDyR0?=
 =?koi8-r?Q?0ziha0l0gwdbIiTpZjAAhjBRArKXR8FN2zNXKBYZek7LDasP4zq8xbWk0TSH6U?=
 =?koi8-r?Q?a/7KtKAQMMp3jDMO4Gc6bCF4NM6Wf7+rEsrunIZdFYQR3cJoDdxZmFwjLqh2h7?=
 =?koi8-r?Q?ZgDNci+BG7n82zAqP+RIrO6A6yC78czFyAZ+I/DIMeAwvw7tzRI1wS4DNWr8hm?=
 =?koi8-r?Q?Aom6CeT7fBVB0S5ztXvABx035LrLl4QBD/xm36iERguS1fVt+8BUD9EORrg+SF?=
 =?koi8-r?Q?zbLeKMlx+sj33pi3kmA79qMTEBWMgvJXlSlRH3FjaWDloQ3DxaNeEnQxaQUptX?=
 =?koi8-r?Q?Ee8kCbAD3WVldt+CGARPc8NUcwrvcofM1cRzNs2+pstvJEcZ8YEqmKQcFHLy8q?=
 =?koi8-r?Q?4H1/e6gqF184OOt/Pk+3Q74Y4N7F7mSeDJO81lt5c5rnHpOD+i//zQhRGJMNCq?=
 =?koi8-r?Q?MhGfqdOwoiezHS/UuiDQcB28mzZx6oE9UgNEUeDjGAZNyLWhmlPnUax4gxEejy?=
 =?koi8-r?Q?HerqPuCOWi2h0+19r9SQrblbdxIq1J9mfjVZZHYo59GlOtyNmce1Gih6+9mroS?=
 =?koi8-r?Q?fLotM7eqzAws2zBPy76Wftn1aqnd8QExGY876jcA93QaVr+Gs3RclXrCquK41x?=
 =?koi8-r?Q?3y52P7nKMdn5dz0ubyOEeCZU72KCQCe5tb0yBEMaVMoBuhgLgvcGyU8IEZZAyW?=
 =?koi8-r?Q?78d0/hkIYr7PJU7y2tQazOMrqT8gbZEOk9m3cgcDiYGXFtYFed0Ov6DcV+TbQ7?=
 =?koi8-r?Q?T2UHsQFKF4DDpw++BCuR3AqGlId5tOGZg8ReHqrz477aFCi0euZx24cxxDT2t3?=
 =?koi8-r?Q?j1uwDWD4Rg82oMYwXU/JKTojdsOxSAIa095qaTgzWA4yj+Q8YOFBYh/3awbrZN?=
 =?koi8-r?Q?t2q73hQcWZSwpqZny3kfejkzAnsJheZLpme6V+tBuZIPmDA5GNxZB+78KUgRqd?=
 =?koi8-r?Q?70AIO/ToRSFXYPLSbEZRi75ubYUgaaEV9zYuzrqs+I+6iWNckr1y+oVxre+X5U?=
 =?koi8-r?Q?uykHwkcy/erAC7H1sv3Fo5CDX3mdO6ttxhB6vPL/qZd1xy80k3BV4g+9S2BCF7?=
 =?koi8-r?Q?fr/5Bcdk+Tf7++BPB6ZfhqdRAe+EEinW9BdCViSzhrtyzlNfUXUFjniZQ1WMZx?=
 =?koi8-r?Q?s/S3zj7h68bq0fgUDeKj7zoFq9baCpbFi1H8HzADCTGsvk8YeaIKkeiBY9HnSg?=
 =?koi8-r?Q?FOwMBFLks/hrZFQoJDf3/SSiOR0f4r4zBwUqmx25Il6y0jfe8P2qt8l+a19zhC?=
 =?koi8-r?Q?MF9VvEIzBkGZLLF7GI4PPkX3DdGzOAR18IWR7BmxKIs/zNaxpfKDjaNZzBOwCo?=
 =?koi8-r?Q?7Lp1mbT9NzluP6a+COUog1E=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB6276.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f34aa-14ff-406e-9b47-08df499c8166
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 20:01:04.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4637

Hi,=0A=
=0A=
Was messing around with the new ntfs driver (fs/ntfs) on 7.4.0-rc3-1-mainli=
ne=0A=
and noticed you can just rm -rf '$Extend' even without show_sys_files.=0A=
After umount, the filesystem fails to mount again.=0A=
=0A=
Steps:=0A=
=0A=
# mount -t ntfs /root/ntfs.img /mnt -o loop=0A=
# cd /mnt=0A=
# ls '$Extend'=0A=
'$ObjId'  '$Quota'  '$Reparse'=0A=
# rm -rf '$Extend'=0A=
# cd /=0A=
# umount /mnt=0A=
# mount -t ntfs /root/ntfs.img /mnt -o loop=0A=
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/loop0,=0A=
       missing codepage or helper program, or other error.=0A=
=0A=
dmesg:=0A=
ntfs: volume version 3.1, dev loop0, cluster size 4096=0A=
ntfs: (device loop0): load_system_files(): Failed to load $Extend.=0A=
ntfs: (device loop0): ntfs_fill_super(): Failed to load system files (-22).=
=0A=
=0A=
--=0A=
theBIT5=
