Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247273;
	b=uldDGAoen5ArazMucZ+ID5PZDPE3tMsw9ixVHJH2O3BtalOtFEr7pzFjkpiqLIOX/oin
	 WBgQ3z6IiuO7vjg6zVnwz1eZf20NOsvVhL/WLtZxrNKZguu2j1UutNM9AKaVV2CAGEvpO
	 Mrq7sWioQqz3MFCyCvMDN9QGBi64zOd0Y8APgx1/6bffY/49fNb67lx6Q/AMetJ00n2kJ
	 sqFEiQC5EaG7YqkhzR+EdLUQqOPGCXYbMoJpWtMJG9r+I++dGCC6FsMtAATO/Ya1CpzsC
	 rhUo/FN6YxOf6rxZ/YAYDaBIbtPwCu7RiXsyYQVlbL5cFzGc7XZmRoZsNdFLzNXmL+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247273;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=uqQObdUpHHYtUe+LeCHrZ/2wo3MZK4ZISN3fNU+Q+88=;
	b=aADIfzSoYl8kdnMvHUDC04+gaRgGmNzTfwC++ygN4ySZ5Ssa1VGpSW5kWFusFAYC/2kO
	 ybmT34Gt4xGGc8jZjxjeXoKZWqdlyuHA4oUxPyV2udVGHL3ppqbAM31MdW68bQVHnfDtv
	 +YjyifehV1txXLwBRoanP4k9AelvJBAGMb09xyfYPN3jFlAU1m5fMbYQXXfZeZcfAxkzP
	 1hW4UbieKNWXor/RNIywqoDarxk19oXwaKa2lf2KfEEIJof53iSRUS4IvyNSk0ArKLSkt
	 BGJrGOlEUP5K2iwJwa7z22ykCf/uG8U3Gn1rTvJEYrRQ22jTSXxNTypr6vdycoy2VLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IyeGbksk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2983606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 18:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2983606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IyeGbksk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794247271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqQObdUpHHYtUe+LeCHrZ/2wo3MZK4ZISN3fNU+Q+88=;
	b=IyeGbkskJsMJ1v8ddx4pfbQ3objBwysZHZMwaLpS0uqF5uTvDc8Btm9g60CvZmoEl3R1uU
	iYja0gTNVvY3gGGejOnLvYrkpuLrvgQO8CQBwjHMK4u4PRAmXkBU4GIClQbFY3FD0ewz6v
	CRZWgnxi+s1eUBoEDdIo7Ys+K2f36qc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-Q-0kTqdZPtqltUwQp3l6_g-1; Mon,
 09 Nov 2026 13:01:09 -0500
X-MC-Unique: Q-0kTqdZPtqltUwQp3l6_g-1
X-Mimecast-MFC-AGG-ID: Q-0kTqdZPtqltUwQp3l6_g_1794247265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 179B1180075A;
	Mon,  9 Nov 2026 18:01:03 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 71C211956087;
	Mon,  9 Nov 2026 18:00:52 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon,  9 Nov 2026 19:01:02 +0100 (CET)
Date: Mon, 9 Nov 2026 19:00:51 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, paul@paul-moore.com,
	jmorris@namei.org, shuah@kernel.org, brauner@kernel.org,
	alexjlzheng@tencent.com, jannh@google.com, jaime.saguillo@gmail.com,
	elver@google.com, blbllhy@gmail.com, bvanassche@acm.org,
	pjw@kernel.org, broonie@kernel.org, debug@rivosinc.com,
	tglx@kernel.org, aleksey.oladko@virtuozzo.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, morgan@kernel.org
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
Message-ID: <avIKUzCKAkfC-wuk@redhat.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
 <atjN3JX7sWx9kpQ5@hallyn.com>
 <avHfm5/mVtuN/oPW@hallyn.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avHfm5/mVtuN/oPW@hallyn.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/09, Serge E. Hallyn wrote:
>
> Hi Oleg,
>
> please see below.  Do you have any issues with this use of sighand?

Hi Serge,

I already tried to look at this patch, but sorry, can't really comment.

I'll try to take another look, but can't promise much, I don't understand
the problem space (I could never reallly understand capabilites in details).

Oleg.

