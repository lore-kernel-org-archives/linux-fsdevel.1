Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858628;
	b=03Zj9PlaCIl9gb8/AAzOPmah5e/OCnpZ5xjhnVFdfV7SiButDLSZZC/WJSQizPQC4sjc
	 /v0mTMehK9sTqFhFtVN9RTpbY7ixDZUI/wLKTsmRyPG5+4w786RmhgioOlKhjEJOWx68A
	 syY+XFvseh8SvYaoOy1gFreME4NkjoKVJgezkitZzyMTeGd9IquFAsZs3p4XkBHAT8jgP
	 bjKYL1d0/MHGHY3ao4tAA8GIip4Y7nlC/vK66bd/hdQlMIfXg4iISiI/DX3BI7z0L6t5a
	 hBhoCg06ioBG1UHolYiIHFz2aXxRiIRuW5vF9W2SN6XIYHgMDkFy7mE2Ay2XdsZdBCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=nNfFTTNka5fIOddFDJ8PGI7qQNrHsISszyTlsbSGy5g=;
	b=0EjLcXIVuwl3YvyHTqZm6vmTZSOLCQlaD5HhYVeuJQ4G7534EaFPYsaap1joiRj/M38I
	 ocrkVyYCitY6DtMd0lpNZcPHQLb5EYpnQB4LI+WXOvQjjfREtti08fEQf+jfIqNPex3Y4
	 MWqRdll1BpdM30UlwgyGDpo/TKXuPk2shhXcTYCi3Me4BemMghUEHX4DPod3SZqN5Pni3
	 DmLikRUrg2+lddFBMURoUXQ8Te2Fk17q6+k4e8dW6BqpgnJCAZ1pi85WS8iN3lWL4apFD
	 BMXCH4A3stdrNnTqA6SdKVWLnGZtrnsWqJLhCiMulDrYw7EfTl7xXItUxs4wvJrOcig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Wt5TkJV2;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD58606A326
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 09:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD58606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Wt5TkJV2
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4ea3c5afaso59965777b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 01:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795858627; x=1796463427; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nNfFTTNka5fIOddFDJ8PGI7qQNrHsISszyTlsbSGy5g=;
        b=Wt5TkJV2cpQRVDm49rBdjWiR1vSzhgbVbPyjEWPKq2vkAp1CiQcWp96Z5MJpXmyjga
         4zalRErWPBysM3c1roCQUVr5fK5rUXmkkSg0vPo0+IiSqHoQD4lJO4ay4ebww2vpNppy
         dH/WMHHQafMqM5lrOkicyHMs1RrILPL+N/tt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795858627; x=1796463427;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNfFTTNka5fIOddFDJ8PGI7qQNrHsISszyTlsbSGy5g=;
        b=UHKjE61w/iAjKjJSe1GHZxwY7kWbtwGT8IzkC3pLLeCgek4/O9kKzn8bX3a+UN+CBK
         FfhezSt4XF6qoX9UTcBAFO83el+aV7EoKPjQJ1lqedTz9lEEmFH8NgaHDRB4xESu0hqy
         pYGaiI0SE5X/xeOlR1bpL+qBgi64G4qwV0xDOw+R74UGCYd76zqcuQoAf7lvVb2FSORg
         IW86RMs7FecQrMkwPesTifwnh8t2rLJSImm6ryAvp6NG+q5SlvF2+37o9xrbKjmcgiBr
         QR5aKAaVw9hhYjqyeY8N6O8HanVBovM4gK5coHwP6pOajqaTRXzefnMzWHhjQ0dHdpRC
         8EsA==
X-Gm-Message-State: APuU4Z+4Y9R3zkhc9Bi0FFaKmOk/dNwsGOLgaitdAjwNy8dnXBKvWMF7
	Z1/xqLM5jJBmlFL/EcpJMjMCDryvqwSj1eUioNssEkVpFolFaPfWu3WQT6oPsK046VU=
X-Gm-Gg: AZFdTZfnYZzY3Ao3v8KuO+cQ4P75YnjY26vVULTQK36Y7DWLBkJ38k8j6CvWUmeyuzQ
	0mzWeBK+NZRVr4DF8ACKifOrLxoajSNtLCAxVFOfH78sjuOojlv7wFIc4vSmn4dV1SI4Y2/niaJ
	R5CMRaUjd51QbGiF2GKiU3i7TsWx3JZh4WPj7Z8fcn6XljtOR++fkvIGRIkCMiPlJ5c0NekSPDw
	hyfw05/UuEqMq5WIaeoyn5hescO3NMout/Egf9kQehsIqymLUlyK1yar5ASTgcqR5o8RH9x7QmP
	Yvck1B15+JvGnayk1hqbfTrZY+cxWJW46uWuP7FLp1bfIlBas12BU3HEFpsoHgdzvOajTeYIokS
	HVyeL4jSiOoJJAXXAJfoBk/sW285PQZLeDW4D10PY+JRgxgrUpGVDTqiFi3M8V0koWFMbW/1Eye
	9n6yEVpMhdCsH1OG3SP89I65kij3BPXUXTbwIPAv5Ie9renaUIG+kOK+VuMoGijAXByojwvqoNi
	aZJOMx/dRSumHe8ZpbdjBv/r6Pxifuui42V2Ae4fLHTTDlE6mFtFxMtq7bPrbwnPNPrSrSAhXLa
	k/zsI3TV6RQnaB/1TIGgqJhKbVUaM7f0jkqnYadKNFH+u8JrR7ICiznaJmZWR22krrEnlsgT/x8
	OrvNDLzfPMp7Dybwgm+PwiFH7dgsOpSn7Crbgrnff0eKUUHICKGUbkfrbxO6NwdMokVs21wOqzR
	ihlCOnsBMVBrLwIpuMsv1NXwML8Pwg68ccdlg8eavSD2Lp3YiS89UEEkM5kDP+c9Qhx6RkVS3SK
	oYRBpsPGqpHXdiul1zgVpU=
X-Received: by 2002:a05:690c:3701:b0:8b4:cc42:9b6e with SMTP id 00721157ae682-8b5204ebe42mr105762417b3.81.1795858627420;
        Sat, 28 Nov 2026 01:37:07 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52036d72csm103270237b3.45.2026.11.28.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:37:06 -0800 (PST)
Date: Sat, 28 Nov 2026 01:37:04 -0800
From: Chris Down <chris@chrisdown.name>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH] timerfd: Support CLOCK_TAI
In-Reply-To: <87tsuaiet1.ffs@tglx>
References: <abuTTv9FC__H_8RC@chrisdown.name>
	<abu8cG7g11DP9nkn@chrisdown.name> <87tsuaiet1.ffs@tglx>
Message-ID: <awqgwKy5zmLqsbyI@chrisdown.name>
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
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Thomas,

Thomas Gleixner writes:
>Q: What's the big change?
>
>A: Nothing. Because TAI changes are already propagated

You're right, I got that wrong, sorry.

v2 will make TFD_TIMER_CANCEL_ON_SET work for CLOCK_TAI timers and add a
selftest for it. They will be cancelled when CLOCK_REALTIME is set and
when ADJ_TAI changes the TAI offset.

Thanks!

Chris
