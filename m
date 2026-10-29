Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793292262;
	b=RfDt3JMjVPSxbfhPFW/YSv1V/aU+KJSpzUXvzh/CP9LprSQcTHwQbXaBZGy/wYckDTxN
	 jB4v31VPeLeUpm2tEsIyOZvWnFFnJhQ+IWHnfVoK7NGbYQPypijU49ghY019VNls3I8MD
	 c+H4RgnpvTIjquPEMKm9gauO4r/Usja92e9FyycrwQlnxt4HBvxV1rxHl3/guzqZcJt1O
	 jCz+k5Gs/TJsN7zr6PuGA8lBPPWadPgpqkvSe7YR3YTGxRzYmrJGyiNUThJ4KDWLRvjJO
	 NowDt5+dARsf8xEMqCqacS0k7WbgTGMJ4DW1KrHsjYV5WG69ud0/Zpx4c2SH82qzKYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
	b=lWFh0CH+L/RxHQH8OH3rE5yAUkxuRd+TMHNGYYD9YOZHYgvjHYdsLPB19f5WA9joREgS
	 YDptGKSJz8Co9JpVZMT7BqcIE2Npxr3AGAUVsLnWjeVbW3KWMheZlJB/jJ4rdx1yflnu5
	 1W6cDY7vQIWVN5+7LI2880f9x+kJeG+/W/y+Ovc351twRkkAH0Rit4SO6uTh47PdUZno+
	 Qq7cLBcdy3xU47RPSlrjLPJbiJubjTRz3ARJ0VACesIkd93/8sYgtdTPSi+l7FfHiw8Aw
	 fVWQbGK6CMDuF/hLrUsjz1grNrYMAQ1OFCSSU4kXwOewjQ4hesAW+eOGqhTMmNQ2/nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAGCmWWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53D606A32E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 16:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F53D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAGCmWWE
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f47feb5a15so443055b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 09:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793292261; cv=none;
        d=google.com; s=arc-20260327;
        b=aviYcJ+OTiU1SQK17xQYc+vmU60MkkJbHqTAEBsjV4JPajpfzcvF04LN++PyuQqwRk
         jQc818f48ZxbVvR9AZyqDipIDob47GjOPsQdyTyY8tuP87y6HlXOT4sr/xx6Oh2vBjqL
         3+DU4nIhx4CdX02jUKZO1iY2jfZsnfmTIH7QpCanj2/uTDtEVkE4Gfybuq1SAC/nJVYV
         tPfleiQDHvB0UyxBG4ubLOXjS9NPYgeNpY7+WVdOF5YF/zgKxs+VPrKzbrTSkcMB0d2E
         rpFfsQzaQovIUjWIY+I74bHR454iOBxAvNTI4Zk00dYxol1eYoqUJZaBDIlCzjZpiyte
         /RCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
        fh=F6tKw0RtMvyOiYYnRnPBwnDzWmiEajz5jbyehIa9sgA=;
        b=pTsSBvorGELxzDIDvtr6735SECiOm11QQWdETBdhMh9PWMNGEye/XVvurBMKwA8dah
         aP6dZuoK8hHkWqHkMISKZbdJ133bW9D8+ge2NUp7zD8lgqW5eIkj4iJp4tx+Uxss1vjH
         +8xp5eoqApyQC7aw05e0YxSkrRBlNZlfqfldhI0XbjyFQ9CNPMYRVYVIANt8wy8DHiM9
         MALQxixwUrXcjUAJcoWUf9WieLm63dXRyFaXlBSeSD/eFG1g3ht+AqWnA3UKkq2UyF9n
         w/MbCAV9thq7Vs8rE15PM+VoZO1CAsAbJPs8HEoFYzhK6BLP716m02yJKWzskt0CMzK1
         vzJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292261; x=1793897061; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
        b=AAGCmWWE4tApKkseEkuGhwQaDIuvXKoBEP7SRmhW41ihlMKO+4bZhK+iS27ObPnPFP
         W9mn2giAl0C5EPi2aGu5+JB5AYe8vcltVgsTQRxVM8RhAe6cHkXtS0jQxbsHav63AEho
         ycRIJ2opAcbgBREJIKoYk9C84et5Zb7zTy17+mBcnIvdPOEjJoBnfS2pTf71n+qSRQ/M
         6NC7uCig4PX+yFvfQhqaCPpXxbnuvAOs+34gUd7jDS3Vkt5hORPPehD+8JwXuQ+DYHHM
         2vWWCETwhtajHRNsaYgW6iBX8S52a8p1La0IFhDg4RTyLr4Spf0kOPQ8GmAcpB6h900H
         591g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292261; x=1793897061;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
        b=gFvToWpnxyVfGXwN2jCsudQuiRl4IrkR7Qco/bW9HWt4Mtwx11RtKuLI2YNn06VZjm
         NbXnvriLt5GX8nD6hLA7cyiH9Fo0/UfjdTctIIbpYP2mWRwPGGLTE4Doaj/u+6Pj51YM
         kOmhX+BRnyMxPmPqvhuL8YLBrOrRa5bOj2taSPDr48l5Djr72TRi61qiTehKiZSMCaOH
         q95B5xqqxJ51kWV6L+x4w66nThTnAXIKUdvTtih5agWiFEPL0Y0CvGWOpaH2M44wvHem
         KHLC40rHJIQA2d6fT93iPf+MAU10DFPvUcl+qmXOz/qGlkfbvXCRBscpqkZZ0EiiS9Cc
         BKdg==
X-Forwarded-Encrypted: i=1; AKwUvBx5UaevzJJuomdDYMDJ+mLVS5JHlPzQGBTC60VKv61tehTgCAMolQg7lWta8D7H/fDIEBofP3UM+Bj8nn33@vger.kernel.org
X-Gm-Message-State: AFq9FYItDyJ6FmQ/M7F0D8kmca9hhglEAb3e6JLTFVDQCMX4q/gjr/be
	XO+JsnFBhWg2i6MUuG9wbjNhvTZn7hUrndzMk1WiNLO/fW1V54Lsw3W7CgdWtY2t2xa7pl2hF0i
	CaJbGPbwFc2fIezoFUsTAQYx/XXoGQRT6b6POHx3M+hU6
X-Gm-Gg: AYBFou2Z7mtgycPV4BBxRbrATTIEMHw5ekR86SunRXN4H2kAl4R01nEzkUXZu5MvbHc
	UEXOMOmTeX6qL7SohRr2hjtT/TqXUo6wxSlz680f4/zdGA5w3nbRaCkVHzzCxIoSVuxvQfumpTe
	BoRT9PgVn/Fcdb/qz1u6VWk+ClYXek8Tspr454XHDRyIEaJsuSYCBsHmDqI6uftd+3Rnl+j431e
	aYLB9npWhO3lpRKi856Hve3NiZSDifwCMnCK89cdapfwBqzmnAD6YUmno2E4+d6QZP6ly2JLutD
	Qz43XFPvamYjKmAumf7ac7LTX77Hii4K6694ybg32ZTkpwUTXPdHQ8vJvrR3e0nRm9/ej460MNJ
	UBxdtgq89QpzP1qiJovCAlC6fD2ujIeeIc4tge/zSMQrreNCnCQFKLZkclyp+CRz4Zc/aWG6l
X-Received: by 2002:a05:6808:3197:b0:4d6:90f3:74ae with SMTP id
 5614622812f47-56384197794mr4379953b6e.46.1793292261209; Thu, 29 Oct 2026
 09:44:21 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154008.67451-1-dennylin0707@gmail.com> <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 09:44:09 -0700
X-Gm-Features: AclHuK_1sASlVUtzDN1GpkTnsvtyNbxnOAThii4_r-uX-r_SWsslPNQvF3mBN50
Message-ID: <CAGEkeHdXVTQU7VS=TxPqmsXMtFFeP=LWw-y04NmcRWJrwHa8mg@mail.gmail.com>
Subject: Re: [PATCH] ovl: restrict casefold consistency checks to directories
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I am asking because I got some patches for overlayfs casefold which I do not
> prioritize because I do not know how widely the feature is really in use.
>
> If you are interested in reviewing or testing said patches, let me know
> and I will send them to you.

Hi Amir,

Thanks for applying the fix. Please send the casefold patches over;
I'd be happy to help test them.

Thanks,
Hungyu
