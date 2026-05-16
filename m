Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DE257844
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970728; cv=pass; b=ZuRC0kxsXAJgg+0FIBAkTdrebFOciJP411RcEQ8USeTVGAlDWRa4W6fqaNQcw+yMFbGfMfhUeEJJ85xW2SR2LhqH/LSkmCk1MIK08GdT0V0VuFQ8NGTSI+f2hwiEsQIPk+Xi82IQ4u1WIVuWv6OZFAoxTUFkMDb9oZicI65EGU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970728; c=relaxed/simple;
	bh=6maWUQxMCbOkG+g0B7vXhxrP+bP4ohpNWaCggQhEEpU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NYLT5aNBuEkvTL5QcUnZpMDjRZctn6xJkX6bY0iA44s1DBMbckCqwLZ0f6rWzi5SLF/WJYuMwU+FBFEHDcc5ph37bew49rkcsth4gwMhUeQ3GYgpIMlkG4QZ0MlX7BsqHpEU9VhdXt+H86YXvCKkJXrpNNvYz6vcRqeBKIShWis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=Z1/wChtM; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="Z1/wChtM"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bf0b47d2f1so5136727b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 15:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778970726; cv=none;
        d=google.com; s=arc-20240605;
        b=A92j8it/fRPIGvV8DHgMFcb5V89P7kqrakjIhKaLKtUnMSnsXhJEXn8xY/4gPtqhPW
         YbCbpMSnvlcBWBV6CrgUn0DctkH3vViwuSYBdsBsb8AaDy/A8NYljUy+Pzu/YVMp+TVu
         +wX73CiIP+jmfihfZoMUE2LgCE9ImCoj1S3hmYkiSWSdmQniZH/JDS+9xe+ze+OwbTEa
         Zs6/92SgpiiobNL57imkBPUku2B2Y9MgcVwX5a/N/jhNFtpvuQc680be7d/3/Bdr08vU
         RQ6TBWOoriGXJTP1eToRp59Rsz56mUOZqPman0S09mF155QrZdG1Dy8G0GZJ1WLIcQIJ
         4s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=S4qc1obW7xrXIS1jY4ZTe6EqMPXBuoXbZ/W0vgGmnJI=;
        fh=yvVpoD4m4ONiG9Bk6vDT8mruprHNPexjYRCIqNNKjpc=;
        b=b7K290ss86wndMVJROKvMWXAi7q9H5SnjphEAYOgp57/DqSUzFPPmdB/20aV63e7Li
         oUzy4TUpLwsbpX4wnR+WCyenObGG7CBdkJhhU6H0+6kM+l907vRRk2V3BqUFFw7dwQQz
         j94epsvVIIKH2AgSTlD2B2whZ9nLCFPLgQg5Lt2t32otWnFhphQmjp+AmTtxqszEY76j
         OwOyU3+HTtDXYyOusfTWPChmrTRX+Z/qctvR0miAYl/CoFfNVgTWDwsipQVD69W26DDL
         SKJ3xzlv2/JBFMKbtasKDAWOF3EEMQbg6g4JZKKA0hA5bWSGhoyjuaEG6n4SwHE958MT
         mLiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1778970726; x=1779575526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S4qc1obW7xrXIS1jY4ZTe6EqMPXBuoXbZ/W0vgGmnJI=;
        b=Z1/wChtMvXzTmNvlZym2gUPH48I35n+Mm8zvoD31M8Os0TQ2h5xDFlIDLn7wCeEdBV
         ghFAWp0RxWSTPB7YOuoGpQ2+4PUn4a5F6FzShCffABsjck2hhZBB4QIq6oMTJTYvuhs6
         cavSALR3eHb77NugBSjpdefkkeQ+ZKNV2/9R/SAue++SqBZmhmEpekG3ZxK5natAXmFh
         UtPayzCYeIQZ/ReoiPPHN+z1ykyAYg+7hrpeqN1DMi1VcrwywdTWQQnjn35/4qfFZs3i
         KCfEgIovMAGV2yrqB0OHX9n6NC2YQrbvZ1Te8B5jzC62JZzoXQMxMDp7XEmNVLH81wDI
         t10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970726; x=1779575526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4qc1obW7xrXIS1jY4ZTe6EqMPXBuoXbZ/W0vgGmnJI=;
        b=KU6trTNl7I1PTNCP1Q/V8hRrtsr7P5vtXf8SJlyiimH7VJVp6SkYjg/tdSmGpkdHNG
         ssA43EFU1qrTj3E7LG8aY9KTWp/wjm8GI5qoYlUjAYrPSkD8TnRXtAe3PC9VypKwymAR
         jMz+JKTAwXy2eVlwn+WKHxGfbSmvYvI990NNzNzcgVkWGVM7IS+bSJMcdJC6bzW+XDu0
         YPpstufGjHr3ZDlKRc7Ek4+7Sh4g5pvnM2rBDnrxijkHNEz3uMRZMWK35MjZqfh1n2j7
         ASjWyoXqNXgXkqMexJz71l3bRDkB2LEeHDS7WscfXievcmpFtIz+nsQDIy/c50JwmUea
         KqUQ==
X-Gm-Message-State: AOJu0Yyfcmk4dFFsCjRHBGvFIPybcZZT9CsehZqaEp8VPlLcLqKcPpUK
	G2l1uN/+K8nCrGABCffJ7wT7ffQ5UuYgEMsdZPjWfpDDUz4JDXm6nJT8mAYBc48uB24KHGU66vA
	LSgpMDmoo2vVmBudplhB51ikVHMJ5gK0kvEivfIFG+XLFrsaY1fBPb6gYKg==
X-Gm-Gg: Acq92OEj5Ry38/Jlt5whIuTfnmJANnLR+7qwtPy8M+ghZq1W7a1HjpLTL4QA0iuZKPQ
	5l00/r8UE6HJwpZ/lZ6Dxqihq7Vrzey/9YjvC2nqyALESmWE9xfQBQw709rA4Q81eluz8Gwnh3E
	IoFG2mfZIL9VSuxtK6uVq1PoxFXKfcAnuy3+ktsH/ulasM9QJgLkltZHojgn0ga6Cs3hiuYMyjs
	ET2hTuOnhaYaIV3zUH/kOBfErElBKuxglRicCVWD+F8Ulyw4+R6edmJAQDiKxgFd0jgJzECL2RY
	FXTEciY=
X-Received: by 2002:a53:ac9a:0:b0:65e:4cea:a084 with SMTP id
 956f58d0204a3-65e4ceaa300mr177685d50.30.1778970725599; Sat, 16 May 2026
 15:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rochan Avlur <rochan.avlur@skydio.com>
Date: Sat, 16 May 2026 15:31:55 -0700
X-Gm-Features: AVHnY4I2Ljt3JcNAAd4Yh-Xa8GKi6EzkpYiwFZGqfi3yNUsvgToXBEYM2r9pbpQ
Message-ID: <CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com>
Subject: [BUG] exfat: rename/move destroys unrecognized benign secondary entries
To: linux-fsdevel@vger.kernel.org
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

exfat_rename_file() and exfat_move_file() in fs/exfat/namei.c
unconditionally call exfat_remove_entries() on the old entry set when
relocating directory entries.  Since commit 8258ef28001a ("exfat:
handle unreconized benign secondary entries"), exfat_remove_entries()
frees cluster allocations associated with benign secondary entries
before deleting them.

This means that any rename or move of a file whose directory entry set
contains unrecognized benign secondary entries (e.g. vendor allocation
or vendor extension entries) will silently destroy those entries and
free their backing clusters.

exFAT specification =C2=A78.2 ("Implications of Unrecognized Directory
Entries") [1] states that an implementation shall not modify any Benign
Secondary directory entries which it does not recognize in any way,
including the associated cluster allocation.  Rename and move are not
deletions as in both cases, the entry set is being relocated, not destroyed=
.

Affected code paths:

1. exfat_rename_file() =E2=80=94 When the new name requires more entries th=
an
   the old slot, it allocates a new set, copies only file + stream +
   filename entries, then calls exfat_remove_entries() on the old set.
   The in-place path also calls exfat_remove_entries() starting at
   ES_IDX_FIRST_FILENAME + 1, destroying any trailing benign
   secondary entries.

2. exfat_move_file() =E2=80=94 Same pattern: copies file + stream + filenam=
e
   entries to a new location, then calls exfat_remove_entries() on
   the old set.

Known real-world impact: Based on the commit message in 8258ef28001a,
Sony PXW-Z280 cameras store metadata in vendor allocation entries.  Renamin=
g
such files on Linux destroys that metadata.

Reproducer (xfstest):
  https://github.com/rochan-avlur-skydio/xfstests/commit/f19dbcdcc37f25c0f6=
7d8657b41a78123f20c447

The test creates a file, binary-patches a vendor extension (0xE0)
benign secondary entry with a known marker into the directory entry
set, renames the file (forcing entry set relocation), and verifies
the marker is destroyed.

Root cause commit:
  8258ef28001a ("exfat: handle unreconized benign secondary entries")

I have a fix and can send a patch.

[1]: https://learn.microsoft.com/en-us/windows/win32/fileio/exfat-specifica=
tion#8-implementation-notes
