Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527788;
	b=NlTGChXpfDCsfJsXYMBQOSMwx/6Or3k0nqqnxxtlUa6bSxh6/4DgCTXpozn7nW4xEPVv
	 KNYEPghbDsWqXAZ+SMQFDoJxtPJfdlTMU100cCWHz+2bCAGKDVysSYuGjetfOgYTqGJGY
	 U62Ul0yvmmrHT8LftRHTDLG40Y1OD9asNKbe9eyvuqJqBRLteFoIRaz9pBe9FmTLmyHfL
	 gFf/Ng8XP+8ygZUTgKwV43RJuViMkLA0xwkRHnLyDIf88e0EHNiOA2pv8Z0AC28xfpkfI
	 q2HEzdIGLWDdw1mR/vHHulupaA1hUT4BZT3yvdnDPYyAJmDm5WLz3+0+/2KM301F+RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=brzZArmNiLtGojpfrPzTD6W6ojCzehjU0YLNHRgcuT0=;
	b=gpmkIU0ZtAiQgc3w7ONTr4kgg3zoRJVwp7jGMoM4T9MVqLvbBoMqaR/nqOlcy057Aq8b
	 k3N9Wl50jgQdupmWki3nx5qtVQcXwxc2Mewhz2K0d85iPHSKIy30lOgm5xLEWfuh09dXd
	 T7LeEGTUYxWEf1DCYxpUuOPwMdWgsJOK6P3oT/d+Gf1N0eXHjFM496N9vbnUvOGkfyYvA
	 PKX8bp8hsC/mwaTZj99TUz2rqcEuPbVITY/4CQvSQwpIN4fFT0bCRUm1ZLATTy8hc3UHi
	 uWYkiYC0LMHmjwl84S/No/V5U3CRkT0s4BFNUaDprViaLT49rEFhe4jdnnYNCQjMhxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LIMq/QQ4";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FF606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 13:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LIMq/QQ4
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso950505eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795527787; x=1796132587; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=brzZArmNiLtGojpfrPzTD6W6ojCzehjU0YLNHRgcuT0=;
        b=LIMq/QQ4IIOm/eSfjVYX9OYrBv+JICUXfm7eoJEziTS8SSvQ1VCdNwGawxg5azfH2P
         zWRj6sNn8svVifemctHXIXbLh6osXMxMaslwGCz41WlgX+85W7qL7VRytLPfQCdAigPc
         uFQCeJRsUmXkPuusCP9lXk/4eCUsXD2M9dEnlwDnbbL3nxayAbGPg7B0gf0W3KYZhkj2
         eR6VRDU7TGfuIy0UOJjTZIG/0EeH35KgrG7/Mb//cNUiRvKd/uxlnUWZDT5WlVVuHNcb
         Mu+1u9F8VM8gw6wmBKpXKX7jK0PBQY63JMQhSktozqFZ5pbgEEqcEgkoARLAiEULvlXp
         R5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527787; x=1796132587;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brzZArmNiLtGojpfrPzTD6W6ojCzehjU0YLNHRgcuT0=;
        b=W+ZXHLLyvrydjNkkzzItMOGtKfyVVox1bKF2f1hLz+oD4JSP4MH3iAmQJ3ZGj/C6+v
         Tlw+D6KcjGKv8JenhShXvACPLR9RtnuL4sxoA3+UUrjVOezpB0tDx3khev+pWdBORzxw
         yjo5+a/ckZurhsoEoVgenfX0Vx8rEcZ2wpeypzOM69xun2ACcUL5v7UlRyjW774UOxPQ
         K+Vur6Ul51pp5qVHo+NavUH9B1AmrDdpfY3w0hEN53MdcDCWUV43Lyao3mx1Z9ehki1A
         2l3MOE1ncSpeIEAobU/5BRrc0FTqVFoVr8hXGVvMcg7jacfd5mAtSLrA6IHat4qapmXH
         ovLA==
X-Forwarded-Encrypted: i=1; AL+hErGEnlS9CvANAP88sjxnHHf9IKNg892k11c1BNqoPV82QUL9GD/rxfp/3L5UO+NPMelnJjtwG7OLiX9nTF+T@vger.kernel.org
X-Gm-Message-State: APuU4Z/b3e8tkk2kNWw5NNYu1mKSdFi9xoMCAxpdRmKH/ahMLvp+7qLK
	KKuyC5srTIBBp4YN/o9S1MRv9gIqVOHLp/6ZFLllciswbBcfXIPpTzQYZ+XwqiMb
X-Gm-Gg: AZFdTZexylahaq1TgO8L8Evcu5tThLbQPNR90TAJRnxvpozXudeaxKoHFWSgCV03qCv
	HDLbgG99WHwQ3DLm+j/e7sIrO0hlYkff89aSxTMA00kbjQryA914ZTerjZZPLgFRr22TlpQRizq
	8Guo8Jt5s9VO0UuWFkSyPsTMoTzxy1TZkkj+K0lgX85qLJ8uR2hMrXytykTF9VN2lg9Wcfkz05N
	+H0bynPG+XlnyAKS5q4KakwgkCV4ZLWwX8HRXBfq6J541CPhBUOybPEmwu9ayr3Wup7GR6ROCLE
	vloAyCr4DNQjroVvOkOlGHJADtX1wOxwW2j66lD9HOLXpT7Udg9Dycg4S9L5YijuSjlM55rZKAt
	00dPaIkRSTS+BwCj7VRHsKDtsBGQ2pmpUc5SIkA7SE/u7rNEwU7NOQQltqUEZZVjocVBVaBsYca
	kAVMSjNHvX6/BQQkLB1zqOoYUcNQYrk8jz233d+n9DbI8yVr1ZxK17pneDkk1FQM+fZCOTK3Z65
	NfTpWGsv9E1PIvQchCJ+XggF4fdkIGXgcLezLtP4hvRR9BrRjLmEsr/TbpQgsxXe4PeDFrDgNz4
	sSb7cCCvp1C18N5m2kLq0Dop5msm9YzghiLOCA==
X-Received: by 2002:a05:7301:241b:b0:386:b526:24d2 with SMTP id 5a478bee46e88-386b52636aemr5818777eec.41.1795527786632;
        Tue, 24 Nov 2026 05:43:06 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:1412:77ad:61f2:79f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm56592586eec.4.2026.11.24.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:43:06 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] fs: sync: fix overflow check in sync_file_range()
From: mdshahid03@gmail.com
To: Jan Kara <jack@suse.cz>
Cc: mdshahid03@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <zwxt7yvljy7znovloyduos7zkkz7eelu7xd6qzkrl6io36bkq7@ecppjcso6uao>
References: <20261119053827.69933-1-mdshahid03@gmail.com>
 <zwxt7yvljy7znovloyduos7zkkz7eelu7xd6qzkrl6io36bkq7@ecppjcso6uao>
Date: Tue, 24 Nov 2026 19:12:48 +0530
Message-Id: <179552776870.188650.15795112817617044806.b4-reply@b4>
X-Mailer: b4 0.16.0

Thanks Jan for review.

It is strange ,i did not found this review mail in my confugured (gmail)
until ,I opened b4.

On 2026-11-19 11:04 +0100, Jan Kara wrote:
> On Thu 19-11-26 11:08:27, mdshahid03@gmail.com wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> > 
> > Use check_add_overflow() to detect overflow when calculating
> > the end byte of the requested range.
> > 
> > Reject negative offsets and lengths before performing the
> > addition.
> > 
> > Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 							Honza
> 
> > ---
> >  fs/sync.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 4a84dd837b86..a1ef2b619cfc 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/export.h>
> >  #include <linux/namei.h>
> > +#include <linux/overflow.h>
> >  #include <linux/sched.h>
> >  #include <linux/writeback.h>
> >  #include <linux/syscalls.h>
> > @@ -233,13 +234,10 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
> >  	if (flags & ~VALID_FLAGS)
> >  		goto out;
> >  
> > -	endbyte = offset + nbytes;
> > -
> > -	if ((s64)offset < 0)
> > -		goto out;
> > -	if ((s64)endbyte < 0)
> > +	if (offset < 0 || nbytes < 0)
> >  		goto out;
> > -	if (endbyte < offset)
> > +
> > +	if (check_add_overflow(offset, nbytes, &endbyte))
> >  		goto out;
> >  
> >  	if (sizeof(pgoff_t) == 4) {
> > -- 
> > 2.43.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
> 


