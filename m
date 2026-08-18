Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE9425899
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069359; cv=pass; b=f0ouOqQBmjQ7EeRdFG4ZbNQNwWukVdR4oz8CBodTIhkv842lcml3b4o3/TJahAXYG6/whXtHaeBxoouim47urUgaowg7BR2MGiajLYUSv1jJDEzsuuuuVE7dDpHVQmgsDhLnH8whXM9wvZLl4NM8m8ZplY9KN9jkW3Sx1oGXd3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069359; c=relaxed/simple;
	bh=YoAd93ZErC/8LkkrEAxWKxV7oXChflGrQ0l89G4j+CQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tFCHHi4B2qZAblKPiq3eVTcCcWbB4U5h2HEEB41F7N0tWW6kZnd0RsO2YI8BFCHFgiMZPOu454drqILFMLZs1lY0kXeJX8fhGV9/IKu0rKQSVeJyIVyVOVUnzKxA5aXp9anqcJOj9C3Zbb/O1MmSQm6+r4tkbMfmMsyUKwII1g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b=N1rDTJko; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b="N1rDTJko"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e507b079dso90287b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 09:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787069357; cv=none;
        d=google.com; s=arc-20260327;
        b=n/Uzde9i61XiW7BeQ2XlKklaMHEP55UoWPIv1Tp54iTbnL8wH34Q9ndBLrkxNRGImF
         J1DBy3yUI81cb4LCrPCrq/2ZcjD16jbNsI/XqgjvtP3Qiaa36xBhwXeLAxjmGStrzifU
         98mY/P2ksyqtmHzqwYYU9vHVnJiKkhGcXfms/jsp40ZYWJkAt9gMn1G44QOeNcKQ/+hY
         kkxwUW/ArR6iTKDF7nByiWf4mm8hY5kphjKmsIP2GY8T78pD6amjT2Z3HoMF64Rk1FuZ
         29RYKRuUuBfUXf/XHL1g9bL6u8R0tLqTO1Hx+QcDESOuFro4lwCt+l/PJXqsOTwiizxB
         2qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WKsnotRrFYIQmdczDREjKFBlGWNW5d1X35irloVy0kI=;
        fh=66MgICiou9MGI468SjnsJ88xX8AtBGGtHJGcOP7N9Js=;
        b=oTFij7c5thqRRJclkmxUerWo82hbyUffqga/rd3grENcJr9hrD0KOcPg9+xrdG9MP6
         zClut8/ZLbXJzrE7v+PxxF0QfliAG63DE88ZIVq40LsJHNowE47HdcrkP0dUHLxYbs4T
         YC3vCtlRrNEErd6NasbT+doEln2jSBaimWGp9iDX/gTBgYxZaGyQ0oCOp3R6f6uNNbzo
         h/OFXcJfMB4IEwXLoVu53uKlEGT/O4BgR3v3/zKNpuMqlEyO/zUurfbKu9dEoeHA9cfW
         55I18aoO4ftiYJRYLYqQi8IUzPvAlJa13VZgATdYw2Wu+xBcNxHmRuL5soY13XNk/5M/
         d/Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20251104.gappssmtp.com; s=20251104; t=1787069357; x=1787674157; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WKsnotRrFYIQmdczDREjKFBlGWNW5d1X35irloVy0kI=;
        b=N1rDTJkoHXxuTE5zvT9rrL55VsgigXrPhEEBixY6/w1AEdqKpOVzvaexxVzkVSe7Zl
         iGXOv1tOwQKUHD8xfQqxzCYVSE6wxyK1m2B/qBOsBlH04/PsAE2uqQUOluhVpMEiTtA5
         owWYUExe9X5o0j1LtOoi4ASl51VKFpdehJt1N+XQDTg2GxxUobARQ/5uBZzVimTH0Vne
         OZIOazl6BVNi3GCmzd4SAzB3TLB/ezoET75eeCgscj7HqloRxcbXAu9iYAbZBClefgHj
         zbq7QGz6fB1F8hAVqLZ5RwCPcDKPir2vmUvpxkb/PKthjGleOKUyCRMDKy5HEa0ABtc3
         o6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069357; x=1787674157;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WKsnotRrFYIQmdczDREjKFBlGWNW5d1X35irloVy0kI=;
        b=rBUiYQn4d+bXghWmNyE0r3HdbEkWu1m5miWbaD8BLuTcFHyaGRUQLJtRZBU/wZ1YyC
         s/xHJQMpw+lb0uPFjnCTqqSp+rZ3AHzx/0wZGMJMoHNeyjKZcbQgb1yyHlG3loEDnhn+
         GPZBLJ2k9e0vZulSkI2TEeFyHKQCXNmkmW6GGn/5jj/x/I0CMDZeiiIB45IKWstUDuAH
         pAmeWGtR08LNixMtTCyjcn4UBBBjTedlOE7Lgw8JX2f3AZSJyoWkqp/rKo4x774SpNja
         7VFWLbMCvY27hXMIUO3Ic3sAMJagsTteuKYYeykfPWxOuZqwFMg6TdQ8+ss6L5f4qtCj
         dk6A==
X-Gm-Message-State: AOJu0YyotsQSHOAhQXqtuYmIDyDv5pYhaHolFVEGEcbYW/Jh/oBwwb6l
	Adu2FrPki45AitH2WyS9VLavettXxhw+pfBCo7eFhr22WOe4qgAZ+2HdtO6wyts7xifpYKIHsom
	BRT2n/2iEYidSdkclOvd3f4ZyS30BhbaL7KvNSl4K
X-Gm-Gg: AR+sD12UlBrFgwJ7VKSTJQHrRA2gTvnByaXiQJDow1uu5X46Exm74NA6PixSMCr3CKz
	edp66W8OZSyNPeG+HyVAJrsJnGmiEdFGItkWUUNyozz7duN70Z84dW7CR6W52eU5T8sJnVMoT+Q
	/9/qZXhaaBaZlCD8I7NyF1OlgacNpnZB0oYrHxP71IPOPZTtubKfqYNzkxmpPPIvl/7ukpZWjqG
	vkyPUSCOpBiBhp5AFEfIDRMXOSzk4FgfcbNy0IvT/37NYmDB/cHHrnXyznBIN/TQfsD8cDPVH6E
	OL4gZ8LhgZMkUaCD1bLnf/PMzeUfzJrJBf6LDI18eYpkGStObs8eVDBD
X-Received: by 2002:a05:6a00:4193:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84fde1500e7mr39261522b3a.6.1787069357164; Tue, 18 Aug 2026
 09:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 18 Aug 2026 12:09:06 -0400
X-Gm-Features: AcwNN1UlVFw6ic0K5kTiv7I6eYZGYsC56CGaiQoPmj2xExpqiS73Lal3-8BcVD8
Message-ID: <CAOg9mST+o6j9A2txJFLtGB+a8eq8W1sZqFiJDM7b48_9jV5_LA@mail.gmail.com>
Subject: [GIT PULL] orangefs changes for 7.3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-7.3-ofs1

for you to fetch changes up to d410cd5303ec59c7cf23dd61423752ce8e9ecb59:

  orangefs: skip leading spaces before parsing client debug masks
(2026-08-11 14:03:41 -0400)

----------------------------------------------------------------
Fixes:
orangefs: fix double-free of trailer_buf
orangefs: skip leading spaces before parsing client debug masks

Cleanup:
orangefs: Remove commented out code

New:
orangefs: use folio_pos() and folio_size() in orangefs_page_mkwrite()

----------------------------------------------------------------
Tal Zussman (1):
      orangefs: use folio_pos() and folio_size() in orangefs_page_mkwrite()

Thorsten Blum (1):
      orangefs: Remove commented out code in find_cached_xattr

Yifei Gao (1):
      orangefs: fix double-free of trailer_buf on readdir copy failure

Zhiling Zou (1):
      orangefs: skip leading spaces before parsing client debug masks

 fs/orangefs/devorangefs-req.c  | 1 +
 fs/orangefs/inode.c            | 8 ++++----
 fs/orangefs/orangefs-debugfs.c | 1 +
 fs/orangefs/xattr.c            | 5 -----
 4 files changed, 6 insertions(+), 9 deletions(-)
