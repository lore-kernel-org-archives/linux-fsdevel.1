Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795284596;
	b=ZBIztYEi3klFdFAb0D6Sju9IlV06PdhR8mytkd/3Lj0IWjAi7mZRd5mXemxV0KoV+7V9
	 pUVn3I/akVEJW63r5bgAhvgEN8HyK0B60NDbUC9fqwxxhJPZgeyR0B7d9jRHgTP1xIHmr
	 THsUTksLKTjs030fG20xnqSdiLNToapbx+kQQJ8aPt8b03hiGGPrXmKTtcOggSHOs1rXb
	 syRVd+qix5W8Vl14qAp56K/W6x+qtWng0ify5CsedsaVt0VJgHq+saMziTo0D/kq1+FkA
	 de5nbJnxT7NPrGWTznVJUGT9v2LkjwmPEaa/v4S3rfhIOJuCQKTDaAjckiXx+sgs3dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795284596;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9C1CMl8WXKICL0GbAnribefCwuW7T0qgk5cnuy1CfKU=;
	b=VkPRk+OG4wI5RXKx9Zf6nXcxDUzz5vDGrq7l+hweRMKfixm7TOOMhQ9eAGGbGxdOX+9t
	 peDvPdSqO9hJ++whKMpb3Pu1WHH+VOqJsDRijhfRbYckUUO4zQi751Gavcn58UHIi8ORI
	 MkvL3g8C+VBRTa20O6+oJAaB1xQQ5ivbisPU4LnBM1PDXmqs+OxhgNEAbRovv/IHgvD+x
	 WtlOOZRUaMAM4So70zlC2fEKJj87IZqiVegsSCz3A4iaZXp+k50YIk80HuwGqQNzR3uSB
	 QFJZ3sE+G0BB9gIbo2hXAg40fUnuNd1IyOV+/4fVwIfxd/+vinDLyI5xd9Iix7ZsBXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XAeu9ahP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.20
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010020.outbound.protection.outlook.com [52.103.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9D606A320;
	Sat, 21 Nov 2026 18:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42B9D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XAeu9ahP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbfBNMbFykG/I3KH8fXjIlv0llZjX72jo7zvtGLfYR0JOOF0NLx3XujBEx6S+mQVG6cpSU67EL+AztLW6wO/AsRWCf0ZmmuoJwdLZX7AybYs7jVjkxfl0I6ToD0U3Bg9eKFjtdGW9/MAHhozz+YSKgPo+CooqxnDRD70kr4LOg+G3x/J4Nbal7tj6q6IL+XBpfL4YMs+jim/lKfHTdoM++24aRSb3ZlxXynW7S9XAkgMDrfBiYzerwRicCaFVS2wnz4seMzoU+13MWQkfQNeq84VTZqGHaDpwrtTOIKzeIs/s+xmon3xuGZcWIMw/IIN44rON0JhQgEpkVIsPXrTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C1CMl8WXKICL0GbAnribefCwuW7T0qgk5cnuy1CfKU=;
 b=BveIv+gIvZffXT+OuuRYOSSymnZ5O+Es6EI38uEf/gEsHwJG97ZYXeLftyKOyyyqbDyOznr/hbSCPNNbOPJSnYjE0hNfSac49q0S0qB+e/1T+vPmy+JvF/pFNZrZ/9JROol7PTyZu8fAFH18FLUe0coXRPiWozVLSH6O5pwOEa1nntm4ogbE4oSEC1I9smeeYh/EOj58o75leJZ16BiUnVc7mUkGjuyd5G06yAYqDI6sdqV4pURaTVh4sNDfpep2aAGG4bGL2UsGbqv94BAnmAoSU/uoCPyWEBI4tvNf84ZxpzB+Rxd6Tp0VCWASD+MBjOzxBueDio1jxFs654SyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C1CMl8WXKICL0GbAnribefCwuW7T0qgk5cnuy1CfKU=;
 b=XAeu9ahPdYlLbNxH0Pqiw4xRT072ngR2JVTo3Pm1qzWelJF2R272mWGETzZtPhNg8Fw4+tMMStKsohlupIuzdsozFK+AVq+DcrLYMaic0C0JWfBQ05hmO32M13rQrB9Mgx1CWYVpm5HCMYTi+3qf8ALPa2/rWxV2065s6tJk5aVdB75Wr7vCEpNomH/5B6U1lfTFMwGaXKEyhMbHh/cBr41+dCX8//WomsQev7go/jt2JQNBQqBzDR+zrCZNnchm42IAr8nT0gYdpmKBtwZf4IlIcHG2UU4zf4b0CAZAmlu2dqEgxZLKPWX+kBKYFiLvKNGxVXhgFhy8RhrE3UFfLA==
Received: from TYYPR01MB8167.jpnprd01.prod.outlook.com (2603:1096:400:116::5)
 by OS7PR01MB957758.jpnprd01.prod.outlook.com (2603:1096:604:829::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 18:09:52 +0000
Received: from TYYPR01MB8167.jpnprd01.prod.outlook.com
 ([fe80::a416:eb44:4807:2c0a]) by TYYPR01MB8167.jpnprd01.prod.outlook.com
 ([fe80::a416:eb44:4807:2c0a%6]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 18:09:52 +0000
Message-ID:
 <TYYPR01MB8167C4C0641826B070DB684FA6472@TYYPR01MB8167.jpnprd01.prod.outlook.com>
Date: Sun, 22 Nov 2026 05:09:47 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: don't reset userspace_init_fs when PID 1 stops
 sharing it
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <20261119-work-fs-pid1_unshare-v1-0-b6a7e468bd68@kernel.org>
 <20261119-work-fs-pid1_unshare-v1-2-b6a7e468bd68@kernel.org>
Content-Language: en-US
From: Akisaira <akisaira@outlook.com>
In-Reply-To: <20261119-work-fs-pid1_unshare-v1-2-b6a7e468bd68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0088.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::14) To TYYPR01MB8167.jpnprd01.prod.outlook.com
 (2603:1096:400:116::5)
X-Microsoft-Original-Message-ID:
 <2c7070ce-b869-466e-b5a5-1740e0bb1068@outlook.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYPR01MB8167:EE_|OS7PR01MB957758:EE_
X-MS-Office365-Filtering-Correlation-Id: a1464094-5462-4c4e-1ad2-08df47faa377
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|25031999004|6090799003|23021999003|15080799012|5072599009|24121999003|22091999003|25010399006|21061999006|8060799015|19110799012|24021099003|3412199025|440099028|3071699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alV6RjVqU2ZVK1hnNGJYV2NiMzdhd3BvMHg1d0tjOThrdHFlQWZtSEo0RUNU?=
 =?utf-8?B?RlgzdGJBWlVHQjFuMU4vWk1JM2J0QUZDRzJzNzA2bGlUS3NTSXRtUUFKVXhk?=
 =?utf-8?B?SWJRcUZybkJQWVhNNUgyRlVkZ2FPVWpqTklZTlhESVdYSitIZFhYTUx0SnVw?=
 =?utf-8?B?OWE2WEt0N3dXNm9obzRYR3FNTjI2Q3FDdXZubll4TCt5Tm5ZQUZiak0zZVpO?=
 =?utf-8?B?NnVQTTZZVy9tVTJWcWJLU0xQL1I2NTRWMWw4NzgzcXVzV0JXUGV2bW9Xb0NP?=
 =?utf-8?B?enBOWFFxS1EvcmNmcmpEUjkxMUlpWDZReVJOUkVQazVaM1BWc1dLTWYzVlRk?=
 =?utf-8?B?SzNLNFI5VEhLTHJLaitKSllGN210L1dpdzAxcUxZSHhGeWZBNDVjOXp5Sk5m?=
 =?utf-8?B?S3JaK29qUUttOUZDcFNnRjkzQTB5d1Y0Zm5EN1FhQ0ZkOE02RXlEaWVpODkw?=
 =?utf-8?B?T0lueDM3a1Vxd3hmSHZMM2g3cUVycTI5VkMwZVhGcDBqUDVKU29qQmllMHJO?=
 =?utf-8?B?RFliWG1PVHZwcXlobWUydGdtb2ZPZEN1a1RWS3k1WGhVdGZac0JaWlp6dzRv?=
 =?utf-8?B?RjViaU93TjZ4THR1STVEQ2tmbXloNEZFUkRNa0JzVVJuK3BUaXFIT1VmQUdM?=
 =?utf-8?B?bU9kZUdjcnpFRWI2TzBMd2llSWIweEtqWGhaL1ZTc2hJenhtVEVES3FSdXFR?=
 =?utf-8?B?TGExZDVya1h6WVBWV29ITmwxaFN1TmJnRWJUcU1yOGE3U3ZTQXVxWlhES0I0?=
 =?utf-8?B?dlNkcEl4M0lydmpXQ2puSHlURjBZalN5VWJ6bGQzNnM4MXo0UmgzLzFBY1Fj?=
 =?utf-8?B?REdaZVA4MUlJdW9lRHp5UjIzdXE3bVNDNnF4eC9abWJLVGtPeHp6UXk0bHA2?=
 =?utf-8?B?R054RW0rRC90bnVnZE95L3ZCNjhkTnBYbWNlR0h6NytIbUJaanlHdjEzQWsr?=
 =?utf-8?B?YWhybDVRV1hCMmtFODZjT1hqa2FzYTdtRDNzc0xVbGxUM0U2U2FMSWFtYlJZ?=
 =?utf-8?B?enMwYUMvTk1TNlpXN3N1OHYzSXlVRmNRRkZ2S1NtMUs1bFptWTZUSlgyLzZV?=
 =?utf-8?B?akVRNDVMWmVreTVnVGd6QjdkakdTbFJXQ0pMT0tQV3JyZWlTK0F2NWllRUJQ?=
 =?utf-8?B?eXhrMUtwSU1MMlNsZjkrNmxONzVkVGJFa0F2YmR5bUNTci9lMVVrY1BwRU5F?=
 =?utf-8?B?QXMzMEhMTkxjeEE3a3YrSk1jelVQYitmaGEybjFieGx5UTdkamVyK2lTc1ND?=
 =?utf-8?B?VFdqTS9MNkIvWExHd0pKWjZIakpEQWk1WTU0WnU5bEhOT0dMZW5YQTdyQVNV?=
 =?utf-8?B?UGpEYUdQdGxwMzJQczIzOHltbGpITkYwaFFUZVp4ZmIwaVZnVzl1QjREM1F2?=
 =?utf-8?B?UEg4Yzl4RThHaVEvZDRZZEh4TWxROFZrUXlYY3psYVNUUEtJZytIWkxhSVRv?=
 =?utf-8?B?Smh1Qm1XZmcxbzRmNG00MStqZW9NNkRMcDB5WklBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhvQXkrMDFwN0pIK09qcUlOdkptaFdFRjB4OE5yalRsWG5GdXZxQXJ0MHMw?=
 =?utf-8?B?YXZaWXNpZ1N2NHFMTzVoaUhIYkNTeFFOTTArWUtSZlBia254NkdCbzhyYjBO?=
 =?utf-8?B?ZFRNMVBCNnZwL254WmF2SnpMalpWWFFKVGlYSmNLdDhnMEFKclNRNGpMa3JQ?=
 =?utf-8?B?dHdZdlQybzY5dmFER29yZzhuMG5rdDlDU0I2eTR4WEhLcHNDNTRDTjVKVGZ4?=
 =?utf-8?B?Z0l1WHNWM1ZWVWo1ZENOb2tHTW5Vc3R4TTNUYUMxa05rcHRHcW00SjhyekFn?=
 =?utf-8?B?dzNsOE1GRGh6eEl3N0ZTTm5XdGt6WGpIci9iSW5pY2tyNVhWNjBmcU90Wk5M?=
 =?utf-8?B?RVZndlhoQ0pCbnp1WkdxUnVQVEVTR1djRG1uRkZ2TmdlRkNlc3VyYkZFbHNR?=
 =?utf-8?B?TFB3bnhpS3FrQnJCZndGNTdrdnE0dmRCL1RIWnR2YVJJMHJyTUhPK00zTkY3?=
 =?utf-8?B?dU83SUN6QjduaFl6bCthS1Q4WmQ1MVlSaWd5V0hKS1g5L3FmaVZKVkltNXhL?=
 =?utf-8?B?TzZYTlBpOXluTENWcG5BenFiZHFFdFVxcHJVSE1RRmZXSHAzRnZnVnlOZGht?=
 =?utf-8?B?cmdHUWNSSUhEWXRTdWJSRHVqeEM2cWtnZmlVS2svZGxLNXpJSktiYTJTdUI3?=
 =?utf-8?B?aDc3S1FzNE9ReEdBMGpkalZhY0t1Y0FjV09GQURCMGthdmZrY2tZcjBrZTN1?=
 =?utf-8?B?QVVvQ2xSRHlnT0c5d2tUM01zMFQrMkw1RHlVWWtETk9UUndPcFAvSjRhZXZW?=
 =?utf-8?B?a0duNFFwaS9US2Vob21SQkJxcjgyengvMXdZYmpRYlJPMjkxcHRRcFRCMFov?=
 =?utf-8?B?ZDBrbU1nc1o5cHNaTWtJQkpaMlRRTkVaTXlvTzdlUnVIZWRZZnJ5MkpCajJV?=
 =?utf-8?B?VG5JbnBXb25YajIzV1BFbUpLVmE4aHNnMktsY0NRcERNZzNKMWUyd3ZVTEEz?=
 =?utf-8?B?emxzUUtoMUhvZVcrcmUvWXRaaFNzTGR5dndsMmI4bWNxaE1mYzJsWDBxTHdS?=
 =?utf-8?B?SUxBbUljVzFmc0hQbWZrTHQ1bGdXeVVpYjBDNnpRQ0VPeXhxVktvMktVdHB3?=
 =?utf-8?B?NklRR0M2eDJyK1dqMG9NSE1JQnZsVHIyQytRbERHeTFEbG9vTFc4RmkzbjJS?=
 =?utf-8?B?KytmazFWb1R4OHFoQ1Q4OXQzSm9KVVYyS0VtbTA4UXVMZEJZV3ZlZkJCMWZD?=
 =?utf-8?B?bFZhYllvV3RGVEJnRGQrdlFLa0V4OHY0VDllTWUzcWZnbjlHc2N3dU1RbkY5?=
 =?utf-8?B?S29kM0FjTmsyRzMrU283NUNpcElqK1Z5di90QWhxSjYzZmhFb2pEUnFDdXlv?=
 =?utf-8?B?M3JacS85MFZYZDdDZVdQNS8vamYvK1lJdEluUlZtdFFQZWJzblpoOHpDMGxz?=
 =?utf-8?B?S1VjWnZHaU54M1Q4V25jcEtUMmlOR0tkTERMUjRydGNVTCs2b0o0WTRDREpo?=
 =?utf-8?B?eExGZjhSTTY4dFlHVnJ2N25oc0JNWGlmV1JUYWFDQUFzSHVWQnpZWlVzS1Jr?=
 =?utf-8?B?dHFuZHJZaUkvaUZxbnNmUU8rUkI1Y0dTQ3BqaHpkM0Z1Mmw1TlliTithc0hu?=
 =?utf-8?B?MXJGZUxidWk3Z2xwRVptTVlwSlp0TDJnUHlCeXNDREV4M2tSdXlqVFY2MUNT?=
 =?utf-8?B?czNrT0tKVHp6TWt3OUFRUkEyRWRRNGY0emxSajVEaEZzZklYMXg1eFdXSEtW?=
 =?utf-8?B?OXBZU3BNQUZ4RUh4ZUxyM1dHSVdJWXpvUkFtS1R2TTZSYUUwV2Q3b0F0ZXdD?=
 =?utf-8?B?aXRNc2x4VXhpSE5wemxnMHExTWpBbjAwbnJzRlM5UWY3ekp1TzYvd3lOYk1k?=
 =?utf-8?B?dmVISjdGY1k4eUdJcG9rc0Fia0ZKbnR2aHpCbVMvVFJtMEVtcVpMTHZ1NFZD?=
 =?utf-8?Q?1y825r7xdsMiz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1464094-5462-4c4e-1ad2-08df47faa377
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB8167.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 18:09:52.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB957758

On Thu, Nov 19, 2026 at 02:25:02PM +0100, Christian Brauner wrote:
 > There are a couple of fixes to not leave stale state behind but it seems
 > that there is legitimate userspace out there that does need this. So
 > stop resetting userspace_init_fs for now. I can probably rework this to
 > something sane but I'm not sure it's worth it. Kthreads and
 > usermodehelpers keep using what PID 1 left behind, just like they kept
 > using init_fs before PID 1 got its own fs_struct. Keep the notice
 > though but downgrade it to pr_info().

Thanks for the quick fix. I applied both patches on top of v7.4-rc3
instead of my local workaround and booted Android 17 on arm64
(Qualcomm SC8280XP).

Android boots cleanly with no init property denials, "VFS: Pid 1 stopped
sharing filesystem state" appears once at info level, and post-unshare
direct firmware loads from /vendor/firmware (ath11k, Adreno SQE/GMU, QCA
Bluetooth) continue to work. I didn't exercise the pivot_root() path in
1/2 since Android doesn't use pivot_root(), so tagging 2/2 only.

Tested-by: Akisaira <akisaira@outlook.com>

