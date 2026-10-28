Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158587;
	b=g7gWuDXWdyfH7DAhCUjNzovr0EURm06S+RhzDIjTRQ//Stz3djntQAgt+udnckg1rfEd
	 FqMrn3py4L/0Ja0rtdv9e8OMzfxCcCMXflOlxXcG6FR+n6dRjEquBwMweFXXI9BnvpiPV
	 SorsT2JrjcXdvonvs1x3REniqOhUMRVp0izdao+Gf3Hn42qXNNUGpO5vjcKp5xyYRI1+G
	 fNEU4nFF5O7CxrkUHBDjnwKeXTCB0PWWKVPo/XTiBBMHswvIujUNMoBelb4ojVOLg7Isl
	 p+ZtJaiFN7S9MiDjGkrJ7mmZ34HNJ3c/y9bk5tO+HEgEc6abRyfocl5jjo52lec4hZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158587;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/wKdshZSDdNYlVlGGww1CWjddpjIdb7CUnZ1PObkTB4=;
	b=XvY1FeNdccLozO02+wVJZbyE5cIodOwakWmOZhxNGIrT1x3HUXGZ9AbsEoLT3PWg/WjJ
	 7bqTlgz2mC9wlqeMyPfX6z0esqoIdTELWOaW+3zUlnDXvaZDncEowKUVLPi6/HYjsP3nL
	 Y+EVT7U/3Myfm0e8uZPVrup6Nd+uJAuJGDHuCSVkLI2eqNUi/edsUv5ERlt958EjYVqkL
	 gZRp0cFmUe/ZDVIqtZ7TWecHW+vYzg/eUkkcJ+O2P26KXefyrh/IF1bdcDOuFalfuk4Fm
	 m9se4cnsjLIeySFzn6H57GLKDb0TZEgznD2vsibAfPd3qhlIYvwTQBCmSBZOKKLvaYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jve2qMQH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BBE0FowR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFD606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 03:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DEFD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jve2qMQH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BBE0FowR
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S0ivGj3816430
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 03:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/wKdshZSDdNYlVlGGww1CWjddpjIdb7CUnZ1PObkTB4=; b=Jve2qMQHUqrEssgK
	LflW6/l7KZ234zJVmm5v4avWWbV1TcUiioz11IU7xNAS3yhP+6JpgpsoOMhZWZvJ
	IPei/BNfJ7ExWg/tShStITm6QZsRQXDRsGswXFZFnq+o9ga6nmbSa33m3OhRLXWT
	jNycF1Ub6eUUeiAVgYu5ZaX6svI7KSL3EU6+K53Rnc/d554YMUVQJALzktVCxxiV
	q+Kz86xf3mp9SK5/sBZk8qiecR2lpX8aT+GhaHVmok95F2t7X+5DAAukw34dJtRr
	PnVGLMYR/XaeQ9zEg45sqiPgK2kxAakvx9jugL9konNgiu/4GNvqT3B3MXccU96s
	aGnIQQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1ktm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 03:36:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so459633b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793158585; x=1793763385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wKdshZSDdNYlVlGGww1CWjddpjIdb7CUnZ1PObkTB4=;
        b=BBE0FowRfn7sN6MDFhJ7FmlNiB3uKdW4e+cRAtWrblI7hD+YFhxqnPOU7tpzisVisJ
         fmEeD90BQvftfZDOccNtAFeLrBTZKfsyegXHwyV0wKlVgLTtCjMFc6HwG5NhJjm3k/C+
         ad5+gAf9zgyISIfOxIIRVunXhv207IDJQjB94mq7+VI9MJMYMNRfO7jOns7wsvAz4bM9
         5ba3tSHhD20XqsJaFz3v6Bl7rN6ldLh2ubAgecoEHWvl0MLS0obmwycPGmr2w1CBLAOI
         eJGZP1D+i5UMtAu5I0NHNr4aAyku+DE5UMfSHnXgokB2sdHVO6EIN0G+P9MH7O/MCHCQ
         6nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158585; x=1793763385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wKdshZSDdNYlVlGGww1CWjddpjIdb7CUnZ1PObkTB4=;
        b=KKATXTumgmawIUzLfqrczvjnE2+Wn4KTUq7G7zHxHIr7B6urVWeGaitmHHokVcLiIE
         Gg7FCz1xef4m8JUoWSh+Q4uP2DARlWYTRFctyf1v22oTkDauBZbRAXBX5z8aCdgPE92J
         OnI3knBO9i893Qy5kMmd2DWYBNo18kRQ7/QEB/f7Lf0XK9enSmvxF/GCe/SEejWKwJLP
         IHmECu50EYZ/cgbB4XwE9V7msuze1imVKL/5m7ZqU+/VOo2dwqWwVgQEsnNwtlTTYyJT
         WNY7Bsec107rBv+Dy4BoTDjGJ7ESYojXYpwYcuImMfSrFuSFIzL9kl4fIt5EnI3mC2aH
         1BHg==
X-Forwarded-Encrypted: i=1; AKwUvBzXiH+rie5cY5IUPUe+uBqSmTEGfvFBynnnwfnTP8702kRaIYE+UbsykX/GRXmih6tk1Hq9yTdHG/i/aky6@vger.kernel.org
X-Gm-Message-State: AFq9FYJHq1UoYLufS/PWg8PdBTDqf31Xg1ivO1vE4VpTGWoogpCsCUeq
	ZrfgKwUM9YD4kGDxSXMzA+CaK4tn7fLGMj4oQAIVe7Fp67EbX5VF0hmfXcqMwrXlJ4rQQpV3ZHt
	k7a8lLb40h5NwR+05GSyavv8NKPd6qJhLlR2QiKW/7vlocwYUqHjg5H5ZBJxrDQ/uosd5
X-Gm-Gg: AYBFou2XiEHAFw9md91fKZ5iPYqZDg2w+lRqGyjhEuTBavsOVxKDjdiT1Ut5YAclKq9
	UAHFyd5vZ/kkTCvD9PEcnnEeVF+dKXtO4uWPTzcqPKmqB/PklakyxvHt4l/FotMkpSL4g4PwahT
	T1n0cTHvbu4Hqz3I+DKQTx5lAlALbGmkQeZvMXHY3nYccZLnEn56rNq/jlXwFjKyji8GLVuHvN4
	wPpPp77TjksudByFk1AF3/ygxOEotQlmhf6BbMGnza4csY/GpoleyA5pevAG1WfVgLuT3+QYYMw
	AnlY7BeS89lxcDvXB8qf1kbgSefXMqZNimAs8BNC8EL2QSSGp8ms6W9xFOnpf0w9QmhkFxwFCEd
	BQjRinNVO8qus6m7Y8fRu3QEyQuwDwDDVdlgPAYhqpH4MtkogK3tKSLS0CAOk0+l4gQz3Xe+QOZ
	I6jCBU+/Bq+P3J4+ttYArefdLXs+YQju6gz3Hrvlx/Cx4=
X-Received: by 2002:a17:90b:5863:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3ae581836a6mr818156a91.38.1793158584980;
        Tue, 27 Oct 2026 20:36:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5863:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3ae581836a6mr818144a91.38.1793158584441;
        Tue, 27 Oct 2026 20:36:24 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a48ec90sm899533a91.6.2026.10.27.20.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 20:36:24 -0700 (PDT)
Message-ID: <e5bd0521-36d1-447d-b71a-94a2e07414e2@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 11:36:16 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        zhongqiu.han@oss.qualcomm.com
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261027223847.652884-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae16db9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=MbyaxBA4Lnn_ULkWIDkA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 7BivziCsJ7OiWHWQPkw5TcV1NvM4k00O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAxNCBTYWx0ZWRfXwzB06oR1SFFj
 qX0scuT64CrRri0P/PiOlepl5kAskB5k1k9b3xIrgRhBnDmfohAzj2mAlbU1mzvh7/+M+Xsk8lq
 eXSYTBTDQrMlrDM3eKgmU3ad1YvCewE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAxNCBTYWx0ZWRfX0GREiILL6VEv
 aJok7FouwZhSDAvhNSOZYtbfZyeVTzY+oUpdEAERCZiHznBAFUr4tZysAd5iyRiVMt6KHYrpMv5
 tv9anU7ZqWFZgBAPSNlsU01ERPBQ+9zAxR/ODQEe9wqU+JLauL4kON4eVUmsleR1kDAqYSw/TLF
 SYydCYoWWzJBSSzcuyQELDwKaD0tYT8oi2jbu9EJX7kQb/1y2VlxfElgafp316WFRtFJyoi/DDM
 RTWpLBqaXsO0vtOtK+CCFe8oUDizTZtjX0lMo6bUCktMCPiCNSk+3MenqMiAQK9tLeaqg/JkLQV
 WsyuLAY7yqkLo2LXRyFC7T2IwTRidVBF7deMwtrDzW++35fjYcjYEVxKAJXhK5TipeVKuw4Fbyg
 MlelSHtVDeYJbT+rrm36gIwPcRVi3/2P3wxfYnFJP8qx4KL+qtA2hqAfSGre8EPq4OLrM+BZIa9
 kiOtsU1T3upDTok66kg==
X-Proofpoint-GUID: 7BivziCsJ7OiWHWQPkw5TcV1NvM4k00O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280014

Hi Ian,

Thanks for the update.

On 10/28/2026 6:38 AM, Ian Rogers wrote:
> Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> in the ondemand and conservative governors so their gov_attr_set
> kobjects have a valid release callback statically initialized, matching
> cpufreq_governor_dbs. Remove the redundant runtime assignment in

"matching cpufreq_governor_dbs" is a bit confusing to me
(cpufreq_governor_dbs() was removed back in v4.8 by commit e788892ba3cc
("cpufreq: governor: Get rid of governor events")), as it doesn't
seem to refer to anything in the tree. Perhaps we could just drop it,
e.g.:

Export cpufreq_dbs_data_release() and initialize .kobj_type.release
statically in the ondemand and conservative governors instead of
assigning it at runtime in cpufreq_dbs_governor_init().


The code change itself looks good to me. With the changelog updated
(in a respin if the series needs one for other reasons, or when
applying):

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> cpufreq_dbs_governor_init().
> 
> This prepares for annotating struct kobj_type::release with
> __must_init.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
>   drivers/cpufreq/cpufreq_governor.c     | 4 ++--
>   drivers/cpufreq/cpufreq_governor.h     | 1 +
>   drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
>   4 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 02bfd46543e9..146a2353b1a2 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
>   
>   static struct dbs_governor cs_governor = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -	.kobj_type = { .default_groups = cs_groups },
> +	.kobj_type = {
> +		.release = cpufreq_dbs_data_release,
> +		.default_groups = cs_groups,
> +	},
>   	.gov_dbs_update = cs_dbs_update,
>   	.alloc = cs_alloc,
>   	.free = cs_free,
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index f3bd3dbe7c41..f8b5aca09b6b 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
>   	gov->free(policy_dbs);
>   }
>   
> -static void cpufreq_dbs_data_release(struct kobject *kobj)
> +void cpufreq_dbs_data_release(struct kobject *kobj)
>   {
>   	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
>   	struct dbs_governor *gov = dbs_data->gov;
> @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
>   	gov->exit(dbs_data);
>   	kfree(dbs_data);
>   }
> +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
>   
>   int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>   {
> @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>   	policy->governor_data = policy_dbs;
>   
>   	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
> -	gov->kobj_type.release = cpufreq_dbs_data_release;
>   	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
>   				   get_governor_parent_kobj(policy),
>   				   "%s", gov->gov.name);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 806d8fb4dff1..1026712bb79b 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
>   }
>   
>   /* Governor callback routines */
> +void cpufreq_dbs_data_release(struct kobject *kobj);
>   int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
>   void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
>   int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 9942dbb38dae..7386d043c665 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -374,7 +374,10 @@ static struct od_ops od_ops = {
>   
>   static struct dbs_governor od_dbs_gov = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> -	.kobj_type = { .default_groups = od_groups },
> +	.kobj_type = {
> +		.release = cpufreq_dbs_data_release,
> +		.default_groups = od_groups,
> +	},
>   	.gov_dbs_update = od_dbs_update,
>   	.alloc = od_alloc,
>   	.free = od_free,


-- 
Thx and BRs,
Zhongqiu Han
