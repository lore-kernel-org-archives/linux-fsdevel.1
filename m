Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11714437456
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926226; cv=none; b=M+trMpFluv+0LbcIobpX9aaI2d1jb24AogysTuAQPAR4H7Rb6xRsRQ3l7xUjqpG/tgJLhx7q9J9VIrbWC3RVJOss1bt5C7M5v9D9WNKePStPUjTJ0FS7KI7VfnmwE0BLnPX9SQiDwMPsJXXv7hDi4umDDH9aSqKxqOTa5Cs9zyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926226; c=relaxed/simple;
	bh=6aGdNFh9whOrRi+BQXiYmM7hLgb2d4eYY0bEvW7ugcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/MkrBYYjX8O+xTfLsQHUKbveM73Lwlyb7TDZCUWA5YvjCz4q2XT8pkBR7DcoPUMlWOBdTGeSDQCKEC7iceaeUFFOPhefWRWyxXXgGjKi6umZ05MAIFAjPIgdInwG23wxygqv8gO3/UKlsGI0hYeLw5UZHvil5ZGvi5y21XWnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alWx9UXd; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alWx9UXd"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34cde269e1bso1951051eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790926224; x=1791531024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oqH+bsEtJSN9lgBpbEOnPSfNHTOAD1Oxka8Dmeox68w=;
        b=alWx9UXdzsXLkVS01Dr3eGwQmyEIq7O2vH2MUWqj3+BIrQmZ0yjjP8wVcWKxmL3tek
         w5AWiWJqqNVHH/82JNm4+hNt1EyBuymyg278pPhVdqt8v0d+KzMJ97tofttTZGBCsICP
         qv+7nUqs9GCoF5U5YpUm3zMok1WincS03TYP38e7trrhThdw0y4+6XjGCMiiexyaxrtY
         zXl0zgJngqldVvAdMGa2ReNAAOadQPG3l8A5R9jCMfqDv1VJ6HMU9XD0zjq+6pA9QGy+
         fuI778y5jNeYNAD6VKipGb96+FnyirsAgvhysITdv0lTYiqnG87U4pfYxpfBDz/xmGPK
         SOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926224; x=1791531024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oqH+bsEtJSN9lgBpbEOnPSfNHTOAD1Oxka8Dmeox68w=;
        b=CPX1DuIomNHh63knKgcIQ7HbfHroVCxFYXnIKsWy3ZJTpRhwZg4dn+00v5niZSiiT8
         FKD1mKQdaSJOqxRutSYZbPwDIwQnLzxpDekpq3yrZT4TdeD+we55SeLxIgLUj/B3Lfm1
         ttAlGZUQn7dJ7jxn1uHxz0fXvrJytX50CumhAB+3KLvs8UZtKiFzQKlLef5AxvN81G7A
         KRdV+a6KqyfrSKcYzUQmMh4N/x5aK1PY8khPg8Wlv/A9TMvudtE5y1qSeY/TS3SKAjiv
         FZ/VrhdU+ACGMn1FncY2wwK7L1xQnURFgcV8KUzEBxm91I1PSd4FxQJSGp5zZjnHxFZW
         gw/w==
X-Forwarded-Encrypted: i=1; AKwUvBzn7fXDktyC3x07DkHQewymUPLPiGh08q+dwV3wG2IxtIxcii8zlCcSEtSldpBb76J4Rej5Wy3eePnSGiUJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJlrgq+Yi0HWYxVBgeedVkt9DK71kvDG6JvmTTNWaZCBZILApHQ
	NlWLjp05waS2y9x+IqLhUUv2DwYjY9EWeNoL7D80L+Sjbf2EBicOXCN+
X-Gm-Gg: AYBFou35NmItmH0o0QcrslMj0rj41use0cOBsMQHVf2yocgDgPSLWVd/fRgvKFdoqZO
	dEMzneuIE700cqLa+6QQnmoHQcwhGVpli/QlhfdF8dbjvPVxNoaAamG4IVbLBpRtTIBiCajYYSR
	TTE9JYx8cik/Ju35b1VXeAAg8S/C2Ph5h9+9VQzR5+9OuNdVXCWNNNXvRMGeMucyb8wLl8Z9qqa
	ljX0twz7/qDQ5HmEcO/I77o+tldo4gcY8DZ/TrvaJ+Ntvr/HYMn9hHfiHaLi9c2m07aoP4KGdAZ
	eFxFoSVJy2Z6m2Efhdk4Wg2qXxMyOsZZ1Owk66ptrjbxVjxYEAAI5vMIOE5d1z5QgCmiB6B5zVC
	J/yNM/N6LUgb2sSFqV7AGfFGIwIAbK+y7CCEq8YW/7cs+X20A3PaRhLlKcH76U+B8jURqTWKakY
	Gv5JDw/bze1667yyRCkpNjb033LJmeN+ZF1eKU06YQGmFKrOkT1tDD/+kq3JU3CnskFsZbJKU3R
	qFMeENM1ABnOUNe35h6fx/4d1yh2OuaSodkrM6uDcYa2ynId7T4uceBM/romBpXwbppnLgJzYNp
	XbCrAS3hbDXIco31HNZjjKZUbtMtLT7210fSrbNr3rYHml9xYqo0jCP1YEs=
X-Received: by 2002:a05:693c:8951:20b0:346:7bfd:8504 with SMTP id 5a478bee46e88-34f219b4be6mr2208586eec.41.1790926223683;
        Fri, 02 Oct 2026 00:30:23 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3510850f86bsm934095eec.11.2026.10.02.00.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:30:23 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Fri,  2 Oct 2026 15:30:19 +0800
Message-ID: <20261002073019.2208696-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

Thanks for keeping at this series, and for taking the 1/6 wording on
board.  I think something went wrong when v5 was generated, though: it
does not apply to mainline 551c722f4080, the base your cover letter
names.  git am stops at 1/6, and git apply rejects 1/6, 2/6, 5/6 and
6/6 on their own (4/6 is reported as corrupt).  The context lines refer
to code that is not in fs/qnx6, such as a bad_inode label in
qnx6_iget() and labels out1 and out2 in super_mmi.c, so it looks as if
it came from a different tree than v4, which applied cleanly.  Could
you regenerate it from v4 on a clean checkout of mainline?

While comparing it with v4 I also noticed a few things that may have
been lost along the way:

2/6: the brelse(bh) is now inside if (!bh), where bh is NULL, so it
has no effect.  The leak v4 fixed is on the qnx6_check_blockptr()
failure path.

3/6: the bh1 = NULL and bh2 = NULL assignments from v4 are gone, so the
double brelse() comes back.  With only this 3/6 applied to mainline
(KASAN and UBSAN, under QEMU), the double-brelse image gives the same
two "Trying to free free buffer" warnings as unpatched mainline; v4
gives none.  The qs->sb_buf release itself looks right.

1/6: the text says QNX6_PTR_MAX_LEVELS is 3, but
include/linux/qnx6_fs.h defines it as 5, so inodes with 4 or 5 levels
are valid.  The check uses the macro, so only the text needs fixing.

Fixes: 1da177e4c3f4 is the 2.6.12-rc2 import, which predates qnx6, and
3377755f1064 is not in mainline.  v4's 5d026c724220 ("fs: initial
qnx6fs addition") added both inode.c and super_mmi.c.

Could you also drop my Tested-by and Reviewed-by from v5?  I haven't
been able to test it as posted, and 2/6 and 5/6 have changed since I
reviewed them.  I'll gladly re-test the next version and give them
again.

Thanks,
Matthias
