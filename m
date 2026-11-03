Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732835;
	b=t8daFyXv3mnh1VNT30GSlrpKQVeRSoCjp37ZZX9TFhMxGbMRb3jW2jXcbGp7gstmyyuZ
	 vip+bN0n9Fl+qvFHlGQPk2+h5EUFnf2Q/y/mM5rsVEsGw3nYXXgKuxOs8LnRCuWm2tM0W
	 ra8YahnMa6+mVFGM3MPnGS4zp2u89uALSaLDg5k/gzyLkbA4G3pc2llhNtrwZ0gWh6gbS
	 hRgvA3H+Aiwlm5nQG7JMH2JZnYNnac6cg01PVnEWJQDop1iBxbBAxQn6gqJtI+tUZ0Uvi
	 scl4lGsBuGWkFlvJaFovzleS62TRPa42pbp7pBW5crV2Q1h7JkJhwF7pCV43bbM2UvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
	b=CKFhd8zjWOTuOpcZtIr2lYBE6VhZg08ynqpBaySEyj2miW4IK2z8bCTzKi9Hab8t0JkF
	 fBYOSJbP7JFC9TogyL5uDnGdAGGlPapzrgrd0L12F5Ei7Gmy3G8BkKZW6qRfnMc/1A5L/
	 CBmiEYDn2ekBAp4PVAJ2MdWFTuuNYJOeqYTWDggWEDnZI9Fr2kV+CBKD2zQWVJQ5oF7Vj
	 3gRvrDjFzIhTqxHS+BZq86eM7GseA5DmaAEZISzEYtd2m9EIMpKc+SgTH7sTA0CvWpUZA
	 ElCjeKi7rD3Sd1jiOeKyDYY1YI8RpuB/Fh/zF3oE+90/QaGLby4bG4ngymvXrRUn5iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFPmZ9oB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893B606A328
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 19:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C893B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFPmZ9oB
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-5179f3beaedso325315b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 11:07:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793732834; cv=none;
        d=google.com; s=arc-20260327;
        b=mlvSK9yvSd5QHNKl8dyRupptpb78x4squW+XoyPMR9S6/hOoBsauhfq57ipKXf4lPF
         bzgsHUX1fWjoTPl/4nbwUt6olqAsAlWDbvD10GKQw7GqC/AoOMbtBSp4SHSIhSKv07k2
         I5RH7uRJ/c9gZ4iFumwDePcbHPKVzSVyoygP67bKCqPvt9jl5fuPa8NOtw0eFFPXdGWB
         qIj6Ll03m3CY5sy0hWqD6umbxh1MyinXmWpNmxofcuZz2VycQZM79W7vjgro4o7+iUoS
         UUtwju7JgmqRrEViglpLFhh4bzdGnT7R3lYb7I+HDGEdRAC6j/nmNR05bCzNdMTH2a5J
         2cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
        fh=2ELexW274+312wjj+HTDtC+Cu0COyVxzFY3UImUibTw=;
        b=T76JBizrlo5TU9UxMDn1XrSG1XUPbZ7m4r8FEWyyxOeBg79HZqxeu84sIW6fJWMRut
         jKpKtolbEiCs1vH3bzd7P4r4U8GSEeS/yVQaCLjqWL74bqMZq2gUAEgB+nAa8drSwmqE
         UiEbZbcZOYOni2GwPzPm2wPijh2xTXtNv9ykq3IOeDZhAJldG3/IWoVnHKcchk33GuUc
         V7qyciLZbhaatY4xGoiICYyZp2S43k28/yCnsQ3G71uZ0N7Rf9DATy8F/SiCV2odwxPI
         quWebXkNRBQlG9I+tShyyNkEpdC4ddzA1TIgKqyb+7lN7Bmi6u+nRAkfQSdnB3h4ZFkF
         bWvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732834; x=1794337634; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
        b=cFPmZ9oBtx6sPRiaoSpMhTsu/UgMBSoUg22SmPUWKZtTiPqs6CrMsI/VE/th70956B
         MVR8J6qRtAb/eVlxAs/9TsKwx2vnJ0sn66lNOYbIGzCABHlV9KKjng1KBw+OVpYu/3kx
         40eO71sWgNJSamIiN9eY5SbzLnTaU4WxNvhggS1NPAD2r0+anEsUsOi1dPiOpMJ/QqbH
         Sdb3LxWrv/zmiWA6L7yfVza5hciJIhXQIHdZqNVu9TCMKknagCQf8HD9A/04gnoO1O9T
         BgRYpijIJydDETK6pBBNJrJD5R1TOX8EvtdDdCewmhiLmn6ktMfYAo+LuB5MJHfGzc6L
         7R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732834; x=1794337634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0+u/BWUffFdCK5nAB/ga6GWLedobIPyeWluDDSR1ayw=;
        b=vOpuu6U9Pg5U2Llp8Uw4s7XYF2uuZorm0XRLMxwqjyeRvFJBTP6hj1yURT9TgkP9zH
         rnHv+mGRV6HcfGOMbCeFIFvMoiCzg+c9FK91S30VqOUWMLKlMoUi+VWJgwDz2XP4tKmP
         Ysfjo0Ry+n0z3mBOCfoEEIAyd1uRk56lEsJDDh3YIredMhDFjNpbAH/5KgL19nM+SSHs
         NrAs+b8yYHLz4Qp7wMON/OthvO/kaXoGLLedb/HgX6++gCHytjNcotxzkxeUa3vvqMAd
         UsCNdTIC9oPlSgMWTi8iYyBCG/3Y00vZW1wKckMExSugbrDh0kN3VTnQEUeiyg2YWnyI
         rYVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxChrDm88gbcAHkuEU5ctZpH64yQwzntGWoVdqMvIMd7IZHTKjKYQND+U+X8bWTRgVcR43WOTNU3kg1CiYa@vger.kernel.org
X-Gm-Message-State: APuU4Z9UL6ou7iEot88mifarjTOgcDxi9DZ5w0kZ6KMGHvIcnQSJsLTd
	735NcepUAihXg0uNZslElqro/dAdjVNpcNpDrJuoqlGn+ZEVDYCqqOzIUWPYHwj5mtrLA4uoX4t
	NDxQhEnfsoV0OfptlS0UMtAxJzSTLkEQ=
X-Gm-Gg: AYBFou0zCSP/V8s0qI64ONnce3a99l4Ycg02/DUa22j7nAciioz9qgFNdDB8cVAZb4r
	GKa/HyfR1kf7S8wa7eupAz83DLN76eaiFvHNWYdpUD741l8Dz3VHGPqOiz29yphPah4/mFdJ/pr
	HsXX+D8iWocBM5X8WHDQY4VkK6vZnBqEgXIH9fCwpz6OdB2tU6ZpNorYiMl4qATkVmUVvqYSnQd
	z3LE2C8hDF2PWvDmUi41+9zQMWCOzc4F0KDYB5AS9V4NrCl6vNrh7tBWMdvgXZHIZNXYf2R7p36
	Y2U63Yh3SwEAEVcKL68drFApvO5fbKo/IPLukv5il1pH5vHo8MjO0Zs7kKzPX2KQCkcywS4041r
	aW6tP31OKXrU9vQ8x7TGPs+T4BA/ozNYpTl+0b1QTM8CGdqMjtWVMQ2u1a5kBGh0XPFIDlK1YYF
	WZew590JkdZb5vaQ==
X-Received: by 2002:a05:6808:17a3:b0:55c:928:69d7 with SMTP id
 5614622812f47-5640e0a4dd6mr8734775b6e.67.1793732833765; Tue, 03 Nov 2026
 11:07:13 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103072234.55611-1-dennylin0707@gmail.com> <aunPPm1d3G6yVCLC@thinkstation>
In-Reply-To: <aunPPm1d3G6yVCLC@thinkstation>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 3 Nov 2026 11:07:02 -0800
X-Gm-Features: AclHuK_s_h176gaiDao9usKlX4K0x8D5lo_mqJC-t5QWJ8dGUnHlKYyTf7Wz6B8
Message-ID: <CAGEkeHcANE5wkbQHkOZ0E0NsJJ-_JaD45yidU8XJatw56tqaGQ@mail.gmail.com>
Subject: Re: [PATCH] buffer: avoid extending i_size after failed writes
To: Kiryl Shutsemau <kas@kernel.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do you want to give it a try instead? Or want me to submit a proper patch?

Thanks for the suggestion. I'll try your approach in
generic_perform_write() and send a patch after testing.

Thanks,
Hungyu
