Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95035DA61
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582608; cv=none; b=LrT5n+zdKtlFuqBb6DsUHAqg7sXI/dIQXwFmPVfVeR2cMPs8R3wkaKGpXQa0ZfO+DBeiboSJ0ojhRk16X28Fu2i1aoTISUd6Z+ue00iKtg6T9ZStZOT+5a8AKcKF1/ybuhrK2Nl0gMHlJIk4EuPMFpUHdp5wgY8HXQFBFPYQCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582608; c=relaxed/simple;
	bh=wg4j50qd+HyVvZop+xqKTij/lmOTb61oW3LmpcIetd0=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXjypnWL4ZZ9gj8nYdGuDLixMMP+i2+IHKGVgWIkoYzTDv2+lnqKuWqityt/EQDhVDfE+l3pqH6l+s+t9Li/6QpZyX4Vf5DQhU3CbHMtyfHJdLWMreNt2kfuvrEsJZCvhU0Q0R5n/O087WCtD60ftRjRDIO6a0Hiv7BNcXNBBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbD96BKn; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbD96BKn"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cc4aa027fe4so256193a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790582607; x=1791187407; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wg4j50qd+HyVvZop+xqKTij/lmOTb61oW3LmpcIetd0=;
        b=GbD96BKnlYNdSdrAknuVm8Le8oso988fVVLKo4QAieuK04pTWRQme5peC2e82L3tl/
         1nzHJp8/kVnCE+6DASYcL+JMEgn91rshnxAyrH+b4KX9oQAkeLoTN6LVGfvNjJLPgT97
         RkuuQbrXkh74pb4lN4CTSD0iFwXqLNBGdeKxfXZlzMfB1GgJqFBGCu8dOT1pbrJOkJm0
         0X6yqdbJnrikRU28v4CSDBajTMHcti+SFUmOMGncdM3SOnziJ7NS5wXu0J31pA9hcQws
         M6vz7q2GEj7+9plU1gGQo/2sxisckmjgT5FDCnBvvPDR6l8U37qUVl7D1xcecT0bBO0m
         3pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790582607; x=1791187407;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg4j50qd+HyVvZop+xqKTij/lmOTb61oW3LmpcIetd0=;
        b=z7xqt/wOWdb8RkBBsbHL2Y3MYp0Gqqv3DuI3ufF37B2YKdIvTSdchHKpsYM5PImhOs
         dcjoojiX/sm3aabLF4jDAdrMS0+lfYXbqxJTUJIVAKyGXESfPifmR6/qSk2C5G1Tn8ni
         lUxRX93SX6c21RHSm+FHGKYFarCWX+lTZRFk6eylaNylROBxl2t4kYiz9CoYW0H2uuBx
         khqNyAQXsXqrO67vClZaZMnCuBAWPLbi62r9wxZNkq7IK0GGuVYPX6qyMuW/W40BGMiO
         pbqx3scpDNkB/9Z60LW24hkvKhyqKgb1CE/mB65ftUc57uTrhZrfpcSMRQ5XBrH2m6EP
         rFXg==
X-Forwarded-Encrypted: i=1; AKwUvBzi+xAq517kPKif/MYw48KU+8sazdLvh/f6zfcKJ+YcQmtpXWEpQ+qN28q0ln7cfPfBvdZZ62tEBGTatpju@vger.kernel.org
X-Gm-Message-State: AFuF++n0ASZqo8849wKF4ol8L3KkH/RT0Lzce/jTEpkVOIXaCF3/UxsY
	93QQHMYn9YPp+QbnziampLWD/UqoPsVnagNxSFD/44Rj0Epij6HRvdUu
X-Gm-Gg: AYBFou00Bt5jhNz7dAqbcuL86mB0BEWKGxo7xr9G3IVevXHTBaepT07BsQRg8lFcMT0
	BzSV40tERoEp/1sXI/4aBOiX0D6S40jlQe+rtMQHzWHFiFSYRuA6ifrQmv1DEEFUAoYeEGbzpFN
	WVJNKR7ww0/RjH9h/iJjY4pRzhsLEF5G96V2NDDpLo/Mo2EENDXVFkvThZD1OXNzvjH89ce2epq
	UOonDGYT3vi6C0FUYa/6avVTEgNJ5kUnb2pERc0xa4UdeKQAdqb1DothaPNST14n8HaYl4ntHGF
	IrrNPcyFkeG1ZuMFGx1foqnOZNUJsSwg305+uEgCre3xfk3LledbksOh8FOmo8+SdKsgaMsrIqY
	7ZolMq3YQxWqnd9HlcgHCmGD5th8B/l7Bc0O+3jBNpo69XNq7WGHxG8feiQBX+5Qhm5FKqlhKL8
	Ho9n0TjzuROjBKlvsXkFjVlRXc//6n9kaH2qWCWoZt4iI4ktbJ7zGRSJeO
X-Received: by 2002:a05:6a00:348a:b0:881:fa65:d4fb with SMTP id d2e1a72fcca58-881fa65e5acmr3366523b3a.56.1790582606929;
        Mon, 28 Sep 2026 01:03:26 -0700 (PDT)
Received: from [127.0.1.1] ([2401:1fe0:5::3b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea19030bsm3775258b3a.11.2026.09.28.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:03:26 -0700 (PDT)
Message-ID: <6aba1f4e.85d8e643.73376.7e2b@mx.google.com>
Date: Mon, 28 Sep 2026 01:03:26 -0700 (PDT)
From: Zhenyan Wang <maximwang110@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Christian Brauner <brauner@kernel.org>, ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhenyan Wang <maximwang110@gmail.com>
Subject:
 Re: [PATCH 2/2] fs/ntfs3: keep PrintName not changed when creating symlink
In-Reply-To: <20260928072801.13714-1-zhanxusheng@xiaomi.com>
References: <20260927180359.3867508-1-maximwang110@gmail.com>
 <20260927180359.3867508-3-maximwang110@gmail.com>
 <20260928072801.13714-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I noticed this regression shortly after submitting and I've already
dropped Patch 2/2 in the cover letter thread.

Link: https://lore.kernel.org/all/6ab97ce4.a24da115.4bfe6.0f74@mx.google.com/

Thanks.
