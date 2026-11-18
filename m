Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795006237;
	b=vtdQDQS/jCLeev5JVgcnNUCNJiMu08MSzD2d/opr1Tg0ua/d8Rujm5XHOqGd4maZrPU4
	 co9Eac0jsza5abRt2tCph8vGDYmkpG5C+cC+h9aICSMTvWXKgcdoFJyyOrzWGOBFW387J
	 jXF5a1DRVRGQ5vRTYKUpQHKV/QKqRiAbG4aOK8F8mfozow3Ieu6sizHmkMoYNlQbRCxzR
	 XACHsBIR9cyc5Ahy4AnV8MIiI/zCuFD8hmS5tbc3SnECaRG42jL6N2jFYUYNeg1sG+4nl
	 UCRXhuX1UyFUmJ7qzXgMzRGyhwZvN4hUJFiiOWhQTKbd2+BvzHNkeSgeO5njDo9neGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006237;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TjEY/mOugVpF374negzHtihdQMtG+74pVKvlNnGIc1k=;
	b=fXC0jDrTsIvm51n1LOI/yXQ7uNMlh5I4AQH0DEDyqr/1g7V+yIm8W/3heS585p3Amo3G
	 OFG4HZK79E8aMMN4S1g7hnGV0SnU7LHrLJXNCYgq3k5lbgqGNI8ON+40NOteYv3/nyc/w
	 Is8qaORwKVwyFGZzlG5gmYCL1LgUprqJjzLYuTOyD/vbUU6DbNfj2Pu8a89UUNWcuUiMy
	 LqpAByEu2rO2QJ9USUQfgp3Yx9Z5tOgwK8onsEbn9xN3a6mclkpLnxSklQjE9GMYc5Yza
	 d3PSKdQYsrroqcdlp+RWdGga/c55z8T0kDXOqhnibcBrq7OfqRE5NAn+2GNY4NIyi/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=aMmRyiwE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.132
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021132.outbound.protection.outlook.com [52.101.95.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AC606A335;
	Wed, 18 Nov 2026 12:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6AC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=aMmRyiwE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQFVo+99BRiezgwcNGsPOZiFuFXlPTAkmLoMnT0pjl2R+9Ob+oV2IXYL+xLU6QGkej0vE7vfnV13wtdWsv+UuyPk4Q4Y1od6GRxN7oiDtj57aAdhsokf3oEGlTf1TjhZM23ZkuxJDcJeiEdJIsaCi291cRFWxQdMAzWt5M8usBgzpYyy6sZPsGHWzRokHS3fERpkyD/9ywcVPMNPNfTABPHX7qrEGzBpUpFAlSRod7iCZAEqgQ52DosUHMMqcFtDWp8w/XvYFlYbibmc0LnNpp88ZFPxYqubQqCHYkaxFuCaywJWO9Bg04b75O1+6K6ffY7Sj2HVpZ9QM91Q8o0BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjEY/mOugVpF374negzHtihdQMtG+74pVKvlNnGIc1k=;
 b=knGaPCVRsHp2qLD8cNMQqDMy++EDbrDkopT9fQ3xrkO/il9I5ZbeO4918LQ0z7tTyE5+vgQ2eO9GyebgIvyieGjPzcMzd5re0Qby1nZZR5sQjJx1jrv2T4A+IGUaT/jNE6NAzBSVBpxml+2LHnaxt1GNoWU7nUCWfGk99/fIORSBh2I9ycLGC0d6b3zYrCVGv43Q3wwxuMKaquWb/jme4RFhS46uyDXKR6vdSPBa6szg7w8Kd+cTMsg0hqgSxdVdpMiALonTQaxrCnMaXY/45TXwKzck210eAT1Cq9Djy+3DnzHWPposeC+oMZU2AIq42LgtmjKH1gLXt0CRjiYR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjEY/mOugVpF374negzHtihdQMtG+74pVKvlNnGIc1k=;
 b=aMmRyiwE1f/hhiJBfBYFJkdVn0GIGnm+w3BHriosZGwRJ32mYBRjpL47Ntyt/T4uJKyfce66BOIUFbbVgSc1pbLlMPw0qv8bXv10klnD9p7/uQywv/1C2cTirxhG+9wwngQeb3tm+qZdC+HOlJluNjZrxoFSlC/yYY4/16lItOA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB6438.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:50:33 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:50:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 12:50:33 +0000
Message-Id: <DMYCLRJZ1JW7.2J89O4SBS6UF7@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] rust: sync: condvar: use
 task::schedule_timeout()
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <aliceryhl@google.com>, <lyude@redhat.com>,
 <daniel.almeida@collabora.com>, <work@onurozkan.dev>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-5-dakr@kernel.org>
In-Reply-To: <20261117001507.1611984-5-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b270db-c8a1-4285-9877-08df45728904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|921020|261021123027099003|10067099003|261022075727099003|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	q42hfJe51/ZPWqTcoZ11k2gxX93tiPPFdCYdSjfq5FlCd974mdQobXpypw8uTDRjzN/H+zyKdINYXNAkBpYr7Z8HZ1s4is3pjeaIJAgT+IvoTvV4mx3VzBYm9PG3nOhegMAS+qP6S/UUx/eH3g5ak/ilLm/r7s3M3bRYWy4q3qI8g23Bj4qsXVEgrvI2XmydfN6iXiGx6VUPJVC66qbvy7CiTgaI0p2mVsjVD7LnBMUJGesVyO6MT3nOpuj7vzD9LrX5rOX9FFY25VyWhFI4Cow+hKjC5T6TrLcO8Ko0NFlJMlR/EqoQnNBKBYGq1wUSpubGT02xTAOvsEsx1nsyVRD/dnxjLBW8K1b2nKCIPs6e6JdtmY4fUKJNkPbnIy3lArfjA63zaCCuUS3DPBtK+68MkaQh4RSQzWcEFAz20MNHALvM2hGO1Ab6fzIEMBU7w5747Y9IUq/PTERgG6wDmTXPTZxzU6nSkgtbdOXmO08XkEQPFlyMFJsiiqKQvOevhsIaYAI5f67+MujJ2P2pOX0KaLhz5G1YSrquB7WZs7u/FLQ5urec53iFWUKMUaz3/CCCZpvhkImQHA7Wc0kZ0vHxBsAwl12wK2uB9AU9h/PZ3jVI1BCFvHKQDovjEMLZV3r0ao55G2+W2nRyvFrUOeka5w/bqwUdImLLSPyftZ/w8FrRdIcmBCFQCZ3kaCqUtMHtxNsjgx8VlY7MSeTZiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(261021123027099003)(10067099003)(261022075727099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blpuc0VVczJTUzVlbUhScW8yb1V2dmNwWUhPK3Z0Ym1xbnZwa0ErMUtIckNy?=
 =?utf-8?B?RGdncHB2TFpleVUvRWZIN2kxYVU4YWJKUWdhaG40T3g1bnhCSlhtb2hIK2hz?=
 =?utf-8?B?ZU9KVTVYcEVzSE1oanJpOFpRc1BFVUI2NmtEd1hFUVgrS1dMN3VseSt1R2Uz?=
 =?utf-8?B?SlJaeGUrRE9uN2dKYXhTSkZ5L1Bpc1luUlB5OW9OUW1VRlRZbjhYYW1wQUVa?=
 =?utf-8?B?YzJqZGJ6bWtRbndoM3BBNVBwYkFZV0FUMlZpRDd2eXBXcGFRd1J4MWR4dVBq?=
 =?utf-8?B?V3k4Rm45SVVLRjh2ZW1taENYRU9UeEtieitOOVYxcWpCWlI5OEp3T1FjRjRt?=
 =?utf-8?B?RzJsOW9RM1R1Tjc3Q0svanVsUzJWN1NDZFhOcWdXdUV6SGtLMEpwOEV6UG1h?=
 =?utf-8?B?MENlZDZqQjlvdXlzeGtWeEJlM3EvTmprbE9sUm9KOUxpY0VpWmJIdk5BNnh4?=
 =?utf-8?B?RnY3Q05zZWFGbGI1Nm05Z1U5RVoyYzJSU09WSEpxM20rT0lTbHRzaENnR2k5?=
 =?utf-8?B?bW5JQW1OaWVRK1cxOTBBVnc0YlFKZUpsQitvUzZtUjdsZFZZV3N4bENYWUd6?=
 =?utf-8?B?emlvRHRQTk1MdXRpYnlZN3g5OUVqeXhGWUExTTNIQmZZM053dVgxQXVpcm0r?=
 =?utf-8?B?MXVacEJWSHNUSFEydVFEaGFkYTNWaXJ1QzcrYVNJbHpDYVJWU2UreWJXNjZW?=
 =?utf-8?B?aXNTL2Ntd3RFUGVDc09mcm03cnMwNFFweTVBTUhhWVZ6TjZKR2hlNEJiRitj?=
 =?utf-8?B?Ym9ueGEyb08vNXoxcWp5am1kZWlwZ2p0K0RuQmlHdHU3MUJlVzhWN0lpNFFq?=
 =?utf-8?B?aWJGRjAvZnpJRVdaYUJzZVFiVUU5Qkh4b2NodThhamU0T1pPOTlvWDg3eXlS?=
 =?utf-8?B?c3NlekE1T1p3YkphendVeENGWEFVcllKTEFPcEQrbWt0WWJQUWJLTlhEbTBn?=
 =?utf-8?B?V3RSTHBjRXI4RVVTQTIrTEFMclNFQ0c4Qm43Q0JPdUNJcmxJalhWaG1TWUdM?=
 =?utf-8?B?RGNkMElkR0NnczJuNG8rL0FCN3BkZE8wUE9pcEFMOUNieTZNaGNnWkNPZGlY?=
 =?utf-8?B?NFIxc0tJOUtBUGhBcW1KOVFMc3duSE1odnZPTUNWNUJFNzlaRUllNXRFQkIr?=
 =?utf-8?B?bVM2RHNYclNJRFdjUG9naVNTOVBtVkxzUlBxOEw5cHIrc2ZrRTUxSDc5L2VP?=
 =?utf-8?B?Tk1JMzJQQ0tQcUtWUTNLTGttejkzdGt4RUFYOU9MRmlwU3dQd2l4bE5aaldV?=
 =?utf-8?B?VW1hbkVQM1BBSVFIU3l5RXFPSlllUVJva3BMdnBiOWtSZEtieUQ3UDl0UTNB?=
 =?utf-8?B?VlhsWVBJR04wZWJyakdhWEdjNlBtZ1VvcHptdnZwYSt0eEJieGh4amlSTVFi?=
 =?utf-8?B?YTJENG9rUENuWWhRbEQ2MUdXZFpEd3ZGbUtEaHQ1ZVdxRTl5TTZ1MStBWWlD?=
 =?utf-8?B?MnU0eTNZbnM2ajBRVGxoK1NHWUdLR0VGb2R3Q3VTc1QxT011dmdhZ3ZSdTdG?=
 =?utf-8?B?dGlYbm5tY0hHS3JOZHUrdElBbEI5ZndSMkwxVHR3Y3AyVDhVY2JyTTJvYXRK?=
 =?utf-8?B?Q01ndnE3OHlMZ1ZNWHRVcUF6SnRmTk1nNXpXQ3c5bXQ2RFBSTUw1UUFoZE1v?=
 =?utf-8?B?YlIyNEZ3T0hCeTNDZ1AyeWRKQWl3NHlPYTBBdnEwVWFWbTk3YW9Ja1JxTk1i?=
 =?utf-8?B?SkZlTElDa2Y5dmJwZmtIbFQzdnBrME5DUXMwSXQyUkFjMFRCeVpCakt3MVQ0?=
 =?utf-8?B?UmxUVXdlOTdkVUlSY1NjZm5lYVdLVGN1WWtpNHdPZTZKRjZwcGNMcU9SM1JC?=
 =?utf-8?B?S1RuRFl6dE5GeHJvcC9xSU1jTW9YZEF6Qi92ZW9LRzdpNkJqY00wMURkZTVr?=
 =?utf-8?B?ZHNDWXJ5OHkvaDhHSHVhU3Jibm10K0pvQVFVTnNzR3EzZmF0M2lqbWc4djJ2?=
 =?utf-8?B?YXhXV3BqYTZUQVVvRTBqdWxSUmRWSVl3UThxYkZ4cHpMYVo1TGRFTjZzQzNr?=
 =?utf-8?B?eFlTamFpVUtQYSs3TmlhZVhNWFN5L20wTWJQTXpZM0JTZnlYaU16bFh6YWFL?=
 =?utf-8?B?dU1POEVGeU1PQ3RWZHJ0eWR1RFhaYU4yVXBDcmZYRGNXY0FDRHprRitlL29W?=
 =?utf-8?B?S0NzakNpZENtdG9LYk5lSFA3NGJpNktkekRkVEF6YnVGU0xUNThLNmRPS3Jq?=
 =?utf-8?B?T0hmWS9pV291QmNqVUlDbE95Q0dUR0U1dDduNTd6eXFZWkNrZ3NjVjJLZlBr?=
 =?utf-8?B?Zk5zMkd2cWRYVnlCU29PbStqOW5TUTVibVZKUGx1SFA0Y0xzZ0UzQ21rVVZR?=
 =?utf-8?B?a3RNNjNsRFYvenA1MXV3NjRZSDVmdkozZGNURTVYbW5UNUNYcXJoUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b270db-c8a1-4285-9877-08df45728904
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:50:33.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIZPScfnGsT4qKAPI/SI5804aEBkJBkdadg1Yt1LrZfn5IOjfM2iBY0yj8bBMi//PmdblF1gIhrC78CzZb1gug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6438

On Tue Nov 17, 2026 at 12:14 AM GMT, Danilo Krummrich wrote:
> Convert CondVar::wait_internal() from calling
> bindings::schedule_timeout() directly to using the safe
> task::schedule_timeout() wrapper. This removes the unsafe call from
> CondVar.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/condvar.rs | 42 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)

