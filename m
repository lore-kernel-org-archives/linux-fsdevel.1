Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850A3A1D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793686; cv=none; b=G7+liLG0NLRx3mZqNzFBeVce5mFlLAKgozGI/h1ejHV27/Kwd3stukEsYifZV/JGoMwrMkuK70GFJM/shTL6GyDVgIR5BSzzpl2sHq/qD0WwV2BBWYbaEQDE5o7DHKdOTCqWTjASNwaAKFaba95u+fwj6b/FE9NcLanSUphZ1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793686; c=relaxed/simple;
	bh=u54493lJbkcmd/+84jAe4am8OweBkH4FGMyaX29kuI4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RyKUzxiVShEHIDTJrIFg+MPnWnv8MRJPpDTulmz7fKilZFQQu75Tryv6cGBuaJlwMxr/aK5FstxihfG1EU85VvoUtcDLmwZ4JCEiaFK8jmC928wZ05q60Sbv9hNoUMp5je7JwztlgcuDXOP9Tp9P79lGGQyF6Mi0u8XWL6J9PwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=0KaS4hli; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="0KaS4hli"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823c56765fdso3625601b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1773793684; x=1774398484; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NA8Te4axz3jvg5v3TSjl5PFwjfVUdZ73qS17BbRLpo=;
        b=0KaS4hlikCE12bEyY5QSrBlHzp5+byyhYHROBEbTh8f2Zkxs7UFBCbXH4kIZMvWcxP
         70/84CmciHwauO9AvvEISnqsVEHdwvGdpXZ3phnfDn568ZE9NwIktmVdhNtDl7oJN4/C
         P2wdf9VvkjM7dc10hq6Mvw03uolAcmnJiGsylxXvCDrjIu6UKTyxvvc4C9nEPVbuRnzt
         EGdA3AKIa1YSu7ArrYJgi8ZI2tVeRjUMSir2SfhBTeDYURVrcgQAX2DeX1wi48E6SW23
         U8PnWu1YMmf06g9iBQCQs57lw6/Sh0YcwE5ljY9+eVwhjaf0/Zlg/Vq8KVshjCi8ifgI
         u8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773793684; x=1774398484;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NA8Te4axz3jvg5v3TSjl5PFwjfVUdZ73qS17BbRLpo=;
        b=XKXgIsBv5xq/9yIVof/nitk9+GwYN2RR/pd5ck36f3FIEk47S9DVeDjQE/cc+7/OMP
         hoT/jhTkK6JSxp0BYVoJmCGPfR+Wf7SAGB8u5r/vD6DLTKY0bOSTKAqXSgv8w5QCAAtx
         5f+a0wFUZ+DcyeZqt2j3cIyV1g4CdCZqaxHC6VsRHszAhdqsH0mlkhSSOx/p3aFdVqhk
         ootfqs6e2CQ9hkwD08gkrqFcbJGD5aKuPo9sLkFcHvjP60ErOAY8X1U/TtL+3ycEwHeF
         N5ZbaYnHtkWi/b/R6AHm2RuO4q8dOhdVZd7H7N8qz3jBaayHBFWufHn0H2tYRkNZ4uzA
         1OPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdJ+Ubz3jREeJxApwB5ljqSq8PXBkIDWg6kDJtl4r8jqQVT68fXHZp7dXtlW1jbKMu5n18t55D4NgS1Bt0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/GRJ17GNOHDbkJ9YGPzeq3+xfJCnYBIy2AbV81q0oTEm0YCb
	kCDKDbBiIZdMDN58789jlj7S+N0foauik1q43CbRFoTZhqKXq8aO2417axJzAeAm+RY=
X-Gm-Gg: ATEYQzzJb1Jzon/WPB+hL8KeuiFaBEzYEYNV2jpeGF9aNqp6AssPB7QLiyyIkWng5Y6
	ge5c0MVQFAVMgIc+wkoQV6I12zXjXClfjAW6pEBu5VeAqTNF9UNobvoDoiGJdi/l6yrkY/JMlcH
	uqaXkLa6Zb3YeTTKZ5lzip3BOZ/Qld1t6tuzwfdZyUp1DE90X2A43xfne4Cao1QJ665R2aA2h0E
	+wnsqn2jI+7edskEPYMPAFqLqZ4w885ISUGWEcYX37jEF/fQDd/nRV55iDmOkyyQP+vAWPhu3Qt
	xIZWFVy1EAPGDXMJi0Huuccuu3Dmylu4TDIvp6/4w9S5vEr4mw74oQB67KtdN3+4WCWmjsNhZUS
	2CW7CF4NEGSTflSQVp5zP1qxwruFBBqdbBVN1VIEzAECpN8fSfAH4uqKuYT02d0c9T/vxIRMGzd
	grHMO7imhSmkIw9rjrzQpx0PWd0Y6H7YSqsNa3lIZWc0fPmVDuagWmGVAIAGBtnrXvNR4ngme3e
	1/9
X-Received: by 2002:a05:6a00:4208:b0:82a:88a:1363 with SMTP id d2e1a72fcca58-82a6adc7e22mr1132599b3a.2.1773793684253;
        Tue, 17 Mar 2026 17:28:04 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1869sm656174b3a.40.2026.03.17.17.28.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2026 17:28:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH 2/3] ext4: add ext4_fc_eligible()
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260317224638.3809014-3-neilb@ownmail.net>
Date: Tue, 17 Mar 2026 18:27:52 -0600
Cc: Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <59A20B05-459F-4FF1-81F4-11C79BF85155@dilger.ca>
References: <20260317224638.3809014-1-neilb@ownmail.net>
 <20260317224638.3809014-3-neilb@ownmail.net>
To: NeilBrown <neil@brown.name>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Mar 17, 2026, at 16:39, NeilBrown <neilb@ownmail.net> wrote:
>=20
> From: NeilBrown <neil@brown.name>

(add Harshad to CC list)

> Testing EXT4_MF_FC_INELIGIBLE is almost always combined with testing
> ext4_fc_disabled().  The code can be simplified by combining these two
> in a new ext4_fc_eligible().
>=20
> In ext4_fc_track_inode() this moves the ext4_fc_disabled() test after
> ext4_fc_mark_ineligible(), but as that is a non-op when
> ext4_fc_disabled() is true, this is no no consequence.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>

Nice cleanup.  One minor semantic change in ext4_fc_track_inode() that
deserves a bit of scrutiny is that ext4_fc_mark_ineligible() is now
always called before ext4_fc_disabled() is checked.  That looks OK,
since ext4_fc_mark_ineligible() checks ext4_fc_disabled() internally.

It looks slightly more efficient to check ext4_fc_eligible(inode->i_sb)
first?

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> @@ -557,16 +548,13 @@ void ext4_fc_track_inode(handle_t *handle, =
struct inode *inode)
>  	if (S_ISDIR(inode->i_mode))
>  		return;
> =20
> -	if (ext4_fc_disabled(inode->i_sb))
> -		return;
> -
>  	if (ext4_should_journal_data(inode)) {
>  		ext4_fc_mark_ineligible(inode->i_sb,
>  					=
EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
>  		return;
>  	}
>=20
> -	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> +	if (!ext4_fc_eligible(inode->i_sb))
>  		return;
> =20
>  /*

