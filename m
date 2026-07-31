Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF3369D5E
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528454; cv=pass; b=o8XfUN6KRXvVwblFgbDflA8TPlCsmzvTJBjkLkuBeAoEIoJzj9dSwHAtOtcbaYngVSybcC1jFQkS7gGQd/wbAbmcEhtKwqDbEpY7VEIyQEg+di6K7DVOAdhTCPSKoOrNr+Uw0v7S0OTzi4xqncaJvO7366p4sJpCAI+TId3fr2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528454; c=relaxed/simple;
	bh=HaZxmJqYx+9+QhSynH8AmDcWjKIvancPwzCQZQKd8SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3aFDzgLhzB1/lKYO6JzO+2lkfJKP0LjpqWvys8ClMwQ/wze46lkT8N69dH8E6EfsKK+Ab2icQkCVX7B6vZ3LsX6NAhwjalVvyD43/tO+4o2cI/eltKi+fsh+c01nRQSse+3YAOiw9Y9VsrfWp+tsUTsOGbdTYUmjs7DZ1b362M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NPlVNPEd; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NPlVNPEd"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848743155bcso702513b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 13:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528452; cv=none;
        d=google.com; s=arc-20260327;
        b=cHd0uhc3ZGkQIvOl6n9qbR06+Dt1dPzWowq16Ib1wOs/KibCMyxA5QB0aUrtUykOIs
         F5L0LcxXD6OA8qCFPXS/fxs3BoRdhTVxm1TKx0j27Q7LQdol2uAzcvsIPbZR3fmZLpFp
         L5zvbK1jh/ugfuJ/VlFAF+I9JKYeQy5dY1kOAfjqpR2Ig3yEWDttMSzM2BNN3sPSU9Vu
         NcIlSPi0ifirLlyyma4/cFEI2oRSkwWnqfssJjGI5ccAqQgJRgUovyGEKLj0+cN3HInS
         QpubfeaeD+zyETl86iF5hKHAbmXkP0cSnbDdz2YsQKKidZSIK123YFgVfG0myasxE1d0
         wIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        fh=g6kkJpn+pBdnRiP8NYOmOs0+eJUjNN6KZIBIsnHI9l4=;
        b=awPwoPkTlrFSG+5x7if55MDw8RP3KPcWOs1O2M6ISibqehl8uhiF0e8pz+Gy/8ngGs
         O6DBE3Ah15HNKw7ThxSLdURqQvrZp+DKg9vgnFvpa03LjHTpCGDGJSafUgW2O3twC0+9
         s14uW0VvUbH+gMThIeU6Dpm0kBu10h6AsCUgTtVUZeedYcIE0PlKXw+//3lyJwOGzGgl
         O1s6ZXXN/f35+inVDtLhmwu55tKbVqahmo/kCBTqAvBG9Yr+DUHW3I3F9lsgRMcN61AR
         qSUmJoEN3mGt3EbbGQntRQeCZaiifgyL4nwE/yjKGVc1EEPEOUA2NGgNykHAbVDlETEy
         GosQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785528452; x=1786133252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        b=NPlVNPEdkpYXPJZFPwbxsaV60UpEogskvIjAU9EuMgFV1M1pdX30eUEMpNbcZd94b1
         2gRxZ3L7whZk6DM0OCU5ZE0mVe9F7l1VNH9e5D1dLNE3sapfOKBfrNlY2INCBYhaUU+D
         Qy1Pq0Ja2OghaPhJ5SD2MfpL2GfwXjc6A41eRM7Wh98mjqfHH7/FYowwpjUsLil1FBHa
         hktynS0v4DT82vvLWYbcGZiCfnJ6rBbK4zjySew1QGWe7DAEKDYewlDQqsklNKGmC0T1
         dOLfERsr1Ca8HHki5+fMgF87EdRPhNsNTZ2h2dVCEHY8YScFMiyAoVk66LKpMADwZxDn
         +GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528452; x=1786133252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        b=T2F8rHtDL9XA6lZ8uCzxw7BDsctegcDtiRXQfZ4V6Z6wEinkytHzOhEsF8vD2M5ASa
         Q85HlndmJ0bzmn3AjHGEdP4BfEYV86U3hjJ4W5/8P6fk7DPrxvZXOKZ7e1OyD4RVW9Iz
         3hbXC2pfOz8mNfB2kdsTmXc4h7epynGndgVZWGutCCZH29h4VBITZW5eQZ3Mp4t93m5+
         EG+AcQy/7Rcekr4xvHPeZSjlF2PRdk6fHsSbjdT3ii0UHn+sEY5IlZo97bB7NnfwEQIy
         6mZjXbzD8PwsxvwmmJ9sKbdF5lWiST4Mqd/oCEuXyCB4S6FTROV/t7htaMB4NApDq2HX
         xXdA==
X-Forwarded-Encrypted: i=1; AHgh+RoIO1xHto6XUAe7rfC6kHqsjDBQ4UolrfwlbTNnMqEgVZSTBGHvK3R/e1qembpdzVltmY1Kj5jNcW8lwH21@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYG9i5/G3eOI/iMILM/75cea37DJOvTGp0Z0gNRKtziKwMg5q
	jblQpFQt2C/L5za6JCYRbZrZyWC9F/I+frKU5cVXjUi/tnqGsAnX73bZ4Oa9a86OGff8emW8bpr
	Nkyh/c6hr6h2OlKoKOKYe+5mmHax62ItMoCNWyYPD
X-Gm-Gg: AR+sD1255ZjtQ7Ga3TdSFNlrpAru4BKnLXL0++CK2FjsIaYoTZmaXef6RlS99Kx6Zuz
	DfEvFwiji4WDX5BcvG1mzg1ZJKOeFDGY7huI0/EiJOPy5O2O/c4ZgM0Y3kmvDowjqG/fEpMsLpm
	6vJh6hOdAEWMZkjzweYB0dJlPuhmVqRGw2ktK03erJUosN7YyRP23GeaXIW43UHBsGRUzPbNVmC
	SqL0t9ZojLloY4HFClVwetqp60LuLlS3zmSQJuz6zuUm+3x/FZmgiDehK00ueyYQf0W08Cowgu2
	oSvSfoj9ekQFCQrXbCCS3tqs3/ZtHpaJcRFkpUotmImi2+7BFyAS8qI=
X-Received: by 2002:a05:6a00:9094:b0:847:7a61:e68e with SMTP id
 d2e1a72fcca58-84ee482cf83mr862916b3a.31.1785528452555; Fri, 31 Jul 2026
 13:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:07:20 -0400
X-Gm-Features: AUfX_mwbFUF3u9BOCn6R0bUcxbx1dq-jZz_UTL6QyKSEwU_IdbxDl3CNhAP30WA
Message-ID: <CAHC9VhR8RpkP-N4J0wGbv167NctjFTOg5Z+n4_M0pjp3Fbnamw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> ...

Completely unrelated to everything else in this thread, does anyone
reading this know if Matt Bobrowski is still at Google?  I've been
getting bounces on his @google.com address for a few weeks now, I'm
assuming others have as well?  If anyone is still in touch with Matt,
can you ask him to update his address in MAINTAINERS?  Failing that,
can we at least remove his email from MAINTAINERS (feel free to leave
his name if possible?) so we don't keep getting bounces on postings?

[NOTE: for obvious reasons I dropped Matt's address from this email]

--=20
paul-moore.com
