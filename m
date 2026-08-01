Received: from cvsmtppost03.nm.naver.com (cvsmtppost03.nm.naver.com [114.111.35.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD222D7A1
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565661; cv=none; b=QgPe5BuCkUj6XgSdCoPCbSHKzKwRidkER7OSHDJjD2vvSUH0ZC6yc0hOxYk4qNqmfTYtXQ9He9vEd+B8OTYxmiJq8OynqAFZcvRyD1gHYXfvIGN8yUJgQs+GnLcN1bdCH8ko229pSs65e+w6tKwErF9zDvXmi7a08EIH0d590lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565661; c=relaxed/simple;
	bh=QLx7gXdPw2Dei/WHKOJ8TTMNtiWbnnKqMyOJo7m0Ai0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh26cgKCasPtlECLcwUeP4G//ptXPJGAdd7JpN3DVuUrBynfeaHWA5hROHj1j/HmhAPxzSOpbWULtBgPflRNQw1ZOtb3BNJRdx5QK1q3xOkZPKtNaVVDFxeywLXeaoiD+EBGkRSYM+MShuSn+pDfdz3+3Jjg256JIeRompYOSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=eh0Fsg4g; arc=none smtp.client-ip=114.111.35.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="eh0Fsg4g"
Received: from cvsendbo029.nm ([10.112.18.60])
  by cvsmtppost03.nm.naver.com with ESMTP id cGsy8rxFStSIK2n+HXatag
  for <linux-fsdevel@vger.kernel.org>;
  Sat, 01 Aug 2026 06:27:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1785565656; bh=QLx7gXdPw2Dei/WHKOJ8TTMNtiWbnnKqMyOJo7m0Ai0=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=eh0Fsg4gDq1/uRk7jgVqXXy6ODcAXi8PinI9491Gy0lojEAlEuN8B2mMemgF7W00+
	 ZojBwYrUHS64/QeUMH3f02jF3RN2ZIaZsd8P9wFON44uc7vC5nZqj2FDc84O1FlsZX
	 CTekGtEVJUv65SgdfI29op+8vX89idr4fD2JTFJDscUKG9HmojUfVFphupPmC5M0Z2
	 YyRecdG3Q5IYZltSxBPbeha6AtwH6JSimqoNkJx8uS8/ZDX3xY8d2M4G0Ua7qSp0vI
	 +W/yEGul322hfOPDytgxcUPlFeBW5A2Ql/7EfCoqke9U4oF+rNTCBdhGxB2wsxJpd5
	 goiTmVHwz9wZQ==
X-Session-ID: TdGbUKsCQEWfTl5myllVlA
X-Works-Send-Opt: rP+8W4eXjHwYKBm9FAF9FNmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: eqKqFxE/FqJZ+HmrFxUq+6E=
Received: from bl4ckhyun.localdomain ([211.41.193.194])
  by cvnsmtp008.nm.naver.com with ESMTP id TdGbUKsCQEWfTl5myllVlA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 01 Aug 2026 06:27:36 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	zzzccc427@gmail.com,
	baijiaju1990@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyeontae Lee <wonju345@naver.com>
Subject: Re: [PATCH] ntfs: serialize the resident read iomap path with mrec_lock
Date: Sat,  1 Aug 2026 15:27:05 +0900
Message-ID: <20260801062705.48184-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKYAXd-Pt1s2M6dnB6kCeHMB2KDqGQ2JoDGGv_-kD+Z4Rc9YNQ@mail.gmail.com>
References: <20260725042421.109599-1-wonju345@naver.com> <CANFS6bbReuJMapSmtQSY+jASmY_di+X28rMFQuYtscBwjCie8g@mail.gmail.com> <20260731091035.28929-1-wonju345@naver.com> <CAKYAXd-Pt1s2M6dnB6kCeHMB2KDqGQ2JoDGGv_-kD+Z4Rc9YNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namjae,

You are right - my version drops the lock before the iomap core copies from
iomap->inline_data, so the copy itself was still unprotected.

I tested your patch and it fixes the issue:

KCSAN, two runs of 180 seconds each on the same reproducer:

  run 1: 206,015 read faults, 415,351 link/unlink cycles
  run 2: 205,732 read faults, 421,672 link/unlink cycles

No data-race reports in ntfs_attr_find(), ntfs_attr_value_is_valid() or
ntfs_read_iomap_begin_resident(), and no "is corrupt" messages. Before the
fix the same reproducer produced 40 reports in about one second.

PROVE_LOCKING, 60 seconds with the same reproducer: 1,199,159 read faults,
1,396,557 link/unlink cycles, no lockdep splat. Mount, read, write and
unmount all behave normally.

Tested-by: Hyeontae Lee <wonju345@naver.com>

Thanks,
Hyeontae
