Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC848097B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464469; cv=none; b=BqOeJNt9buzCz/v41oQxp/YY2AH0tao6dKir3k0lSQZeOuQxWHe/XRUK0gVqRiUHBPOwOPFDednh2P9PSEjvmj8zLm319eNhHVudJNLb7rBcaitg8vQ+jmrz8bn72tTCXWXUYwhF91HbO5H4Af3C9msEydVCJv4EWeN3K1jH6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464469; c=relaxed/simple;
	bh=YInhToU3yGXxItWB0UeOfhdKWHVJWIlowwAZet277jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+d/3Nv72xy+QbsMS1NClh0gnTrG3znRZOmfXjwo4gDg4PZljAezYw3aOIiXvGikyznt+x8l7QIMUTtDFuJUKF/e1LopLGyLlRcWluc1nEWjoEQ3HWBVkdtiL5U/vUann3Tpcn078Ojeb9M9PYbL7WShYLBrPOCgYiRQYfpf5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=lqowsgwM; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="lqowsgwM"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8253bc5a613so3768568a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1791464467; x=1792069267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YInhToU3yGXxItWB0UeOfhdKWHVJWIlowwAZet277jM=;
        b=lqowsgwM/vrEZQrCd+Fvn7U1KhVspXyyxalpkO94RC0yOLW3+SwifZGwGItBmUhI2S
         6Fy1/qtCF5z5er3B1qYVSGs0WK1BKkCcwfhDAN7QFQYw94m3OTIdkhxLD0a584co5BZn
         fdvUS5jkasdCSzw+7cV9rvrcKdGoSagnOYIlmajiQijmrR3CZAU8O3wVtq68abOqTNAC
         qtWnx5+q3XlamJYD6Nq8VywtF8Gu1x6wNTx+yqnQ1ypY1xWWhZ151npmpf/vjIdgLG9X
         ciiEVstr6GVpKGbzleGjSbn6ejoOxjw1jGGw+pR85Db3LFyIfeG4RtiNpK3zDW0dwteT
         GQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464467; x=1792069267;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YInhToU3yGXxItWB0UeOfhdKWHVJWIlowwAZet277jM=;
        b=VxVcJ4azHB+By3xEjqqmm69QuHOlC0woX6iA9tVhREFwF/xgRI3KwS6W0W/y8wPowM
         lEgqATGrzvtHmy4UiMyRnxx8VUj7KXJz48M1k29w92vDCiOTdVaHK2MAaik5Pf8WgRXS
         lPDiPstk6DPe13qVzfTVieT5N1ZbyZZy+Q4ZIl9z/uAJLV+o7E89dLvCja7mm7T/OHkY
         ZpKwS5UW9eDIM87OjmTz0UAsQot/JTQE4CsP1560vUFIvn4eOrn2MoktHXTS+3i5ZrYU
         qHM7Neoy5/rbczae1Nop3aEwTzW+UI2QYNdUTgTyZm0LRgrzUdlSTPWOmZ4L/C/G6RFV
         Dojw==
X-Forwarded-Encrypted: i=1; AKwUvBzZH/H9u2C2eKH6L1bXOjhTgJ5h7eQTnuow1D2K8Mbcf0qfcwnewS5r+ptmaYX8ZgtQ4EOI75TnGF8WR61H@vger.kernel.org
X-Gm-Message-State: AFuF++molkZab3ROLep6BT+JoQmoX7wCyPGqJM2APwhgC71KjwrUVumH
	FuwRHjc3MvgWB0nzwnfLw7U3gQXCIF76pblbiQIusuKP4VoG0irYhfM2Zk6NZwEghtU=
X-Gm-Gg: AYBFou0yuWsPPMZR8nZrrC9ejtSd9ibwiQKeLB/5rgjwg24KnhsKJr6ij0LErpMA+wC
	XwBpxNpD0FErGEGdGdNgGa1H60/P5lVL59wEXqtHTqeTMJG5GtcOxgTamrTlCaxqsrDnkIajNKc
	JycezGIcST3zpdmV5tuCUXeDPKNDUZacnQcbphuOBrUZwiL7taf49zlsB1buenewO4oihv5PA8a
	7uEm6pnJXqxQ6BhRmIgOCMK3zB39Fav5XOaj6SHUAZJh9v2PKdySLJy9Hkb4DRahRHWzj8iiltu
	cncIrYqpR+7cclyeO39jbzXagm/qQSUVMsNcMOXLY1efGZQsRXRGYHRofw4WJMwjSX2+b12eJD2
	1VHXZmS5dP9AD+paO6ENi+SbH0v3FPDB75SPCJrXl9b9HYvqhLtMTIyNFD2lqb4GErxvdAgb2Cl
	2ivdaUAf4KtaxYjUKsXHfIGUExFeri36YBU0EnZfevNsm0zLonRIJ0sbcJzVU1npdoKeQ7cYApS
	fjMkQDLVCAvIxDBsg==
X-Received: by 2002:a05:6830:2b14:b0:81a:adf1:ae71 with SMTP id 46e09a7af769-82acc65f71bmr7181675a34.4.1791464467021;
        Thu, 08 Oct 2026 06:01:07 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adbdf2a92sm6008498a34.5.2026.10.08.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:01:06 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Danny@lightningiq.io, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Danny Pidutti <danny_pidutti@hotmail.com>
Subject: Re: [PATCH] exportfs: Release the get_name() directory file
 synchronously
Date: Thu, 08 Oct 2026 09:01:04 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A4D58861-5753-4284-8C77-93025701E58E@hammerspace.com>
In-Reply-To: <20261007164648.50493-1-cel@kernel.org>
References: <20261007164648.50493-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 7 Oct 2026, at 12:46, Chuck Lever wrote:

> get_name() opens the parent directory with dentry_open() and
> releases it with fput(). From a kernel thread, fput() defers the
> final __fput() to the delayed_fput work item. NFSD threads are
> kernel threads, and NFSD reaches get_name() through
> exportfs_decode_fh() whenever a file handle's dentry is not
> connected to the root.
>
> On a filesystem with more directories than the dcache retains,
> nearly every READDIRPLUS needs a reconnect. The deferred releases
> arrive faster than the work item retires them, and each pending
> file pins the directory's readdir state. On ext4 that state is the
> htree fname cache for the last leaf block read. A 64-thread NFSv3
> server under a parallel tree walk showed unreclaimable slab growing
> by about 90 MB per second, and the same workload on a 5.15 kernel
> ended in a global OOM.
>
> Commit 5ff318f645eb ("nfsd: use __fput_sync() to avoid delayed
> closing of files.") stopped NFSD's own closes from feeding the
> delayed_fput queue but did not cover the exportfs reconnect path.
>
> Release the file with __fput_sync(). get_name() opened the file
> itself, read-only, on a directory, so __fput() involves nothing
> that could wait on the caller.
>
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Reported-by: Danny Pidutti <danny_pidutti@hotmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/DS4PR04MB9846BA3C16BC5ACE=
D8B589228D952@DS4PR04MB9846.namprd04.prod.outlook.com/
> Signed-off-by: Chuck Lever <cel@kernel.org>

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben
