Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB43DFC84
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914061; cv=none; b=Ws5xIe0V/nDylmVrkqSug/5mDmVUqA+m+OyXs3idqFVK76s0DN9eIoTmNOUh+Q2+Gn7sBQsTYYSA4HkwmVOveyRQMb2ZWj526feZ9ke3zsptyFi2/wqkCJ3ioN7Nc5+kPpWt3Mix7tXI+cgJV/gljiZMoN99j12PvHSg1L/ribs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914061; c=relaxed/simple;
	bh=J6qYZUiLa3PQDxYt5MfRmbE/eSrWZpjv6rUJGu1HGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndJTOd0eyxAqYkN0ueYRvR3bDgECiZNt7a3viOOKZoKEisKxLCYSoYauSmRWs5THMlv2rtqWBwy6DytZk1WqZqL1o+I0s+zHQxQ8aNo2DoYrlx8IrzCtgounmlSiHXw3h0sNY8ccheu8+WcZVTIUy+Z+DlSoacIlQK5y90O7mro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJqR2h3o; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJqR2h3o"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so642710a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914059; x=1786518859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6as8M7FVd7c+UbPqlYJNNyB2XLvJfla5C2MEVFuars=;
        b=WJqR2h3ocUWGZI8BQlYhH2GvZDYuC3q2sPW+oz11yaaOwaiG/XJwIuxblbj+SGVvqS
         KmyRF268AyPmtmMR3+nAi5+AZvrHWqCPpU9d2+7AOH9ZRxCFJjTAeqHXfiQe/bAq9Iyi
         zA/FpK91bOt351dXfYDdPiodKl3oNsTfVbUEHJBE7R671KsXvCGzMwfVr26W66y0CkLD
         P22ZJF9J1Ubsm+CLlQs7CExh9QH+UKMN6AVnNNbyuGIdJFG8toXXYjbQPaK6JAUFxCCD
         c8mJNrQsI7nK1+TGYpzQMq45gLqBl8Gy4q8kfpAnbD0MsIgkOIShPffgziVOxBtPFLeh
         lEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914059; x=1786518859;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6as8M7FVd7c+UbPqlYJNNyB2XLvJfla5C2MEVFuars=;
        b=EJmooLGXdtPtrJ82fEGz8rIJjwvXUP400OnInW2jBzXZ49GXIf9xQNeL0hFRxYLMxK
         ygOArjs0fpkH0qmoohesnIl07/Sq97Y05sgdQ1UxViU5pni8TJRBP0cf+CZTQFISq3JT
         OEWNmKtuYA7Qq0Wn9T3oUGZA8bE7NkLWyGPc93Wnt4fo57Nm51gLH9cFtw0IXBJJQC8O
         3WsM7dpk1ljDkGwNu8fdn+GEbpp097wHMg9Eo5IIF3eARGdw4sLoul/cs1/865rils2w
         ZsRFxX1z1WwhXRpBU4T+7v1+DyxmV5nSnBS9f9QMZo4oj2WY1hOEHSvnfRU3sWUhn10a
         syXg==
X-Forwarded-Encrypted: i=1; AHgh+Rp755ZK/X5W3Z+TUWpbC5Ik2JL5xxjruBytf/oOxXajbf/GJu6cKX/2IQVLWeQQkhymEe0q0B6HbCDCGvIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLqmzOdUt48LFHMI9DJucqkrvDvzVItw6gZ8K+xStjlNZBYXo
	8Td+SmfywCyEqdO/ai2J9ldwIqrsz6MAK5HrCYUw7oUj1CPnRR15ce+G
X-Gm-Gg: AR+sD13OHt7xllVxxxgqDU3hZ2ZK69UsW9hBwDnubXm4o01Jz60QCY/d38FS6mbJwLp
	D3l89kPMpIjIdnyrsjlzIC6r8FG7KhlqZWHYxvi8oDHmQHrAfxYyzGM53CXw46HaYoPElCaHqkV
	A3BYWMx7UuhhvNEokTzIdaIlOBbcW+E28nbYZKT1L2V3jWqfYraOmh4rrQB5mHJnXWWFk2GemnA
	S8r+lTgbHO6Yb1QBOcmgDsiCooi7W4L5v9VOlCH+eRj7iMF2iWsuOALThk+bpLQZ/4lLc67BGCI
	T+Uj/IyfTglz1+hMryMmJGhx+MvTuXEuKGqfa3pGzjq9CtNFh/iYJi8iiXLJ2xeQTyxbbJ619iF
	WYGl/RB8hS71giuwBxqvWUNPwUHX/1DTqeYa8vx3o8B9cS6kE8WHre8I2S5J911Z8ZH9ZhqqA9J
	QIhtwT9F+wHPC5a7ho97I5mntUvO6TCnHv23NG5ik/dCsGdhTyJIzTHJp/SX1hgU9pgL/2h/gO7
	0r+jqgib3O9sJcS06CakXlYMf8CEaq3y3+FAABbey6DRL3RrIGU7ROSDUse0/gOiCAt9YYM1WFJ
	cNQ2ZJuFHOpZDD9IrNwBHf0qkowMPp4Pc4Tw1BBbbDF4Cuy9Nn/OFkPwcIyjuw4=
X-Received: by 2002:a17:90b:53c5:b0:381:bc4c:da5b with SMTP id 98e67ed59e1d1-3903c61098cmr5020953a91.18.1785914059234;
        Wed, 05 Aug 2026 00:14:19 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392aef87sm2158639a91.13.2026.08.05.00.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:14:18 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ansgar=20L=C3=B6=C3=9Fer?= <ansgar.loesser@kom.tu-darmstadt.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 0/2] vfs: report truthful FIDEDUPERANGE progress safely
Date: Wed,  5 Aug 2026 15:14:12 +0800
Message-ID: <20260805071414.3414870-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FIDEDUPERANGE currently reports the requested length even when the
filesystem shortens a destination range and deduplicates fewer bytes. A
previous one-line correction was reverted after generic/517 exposed the old
expectation and reviewers raised the risk that existing consumers could loop
on a successful zero-progress result.

Patch 1 makes a non-zero request shortened to zero fail per destination with
-EINVAL, while preserving explicit zero-length success. Patch 2 then reports
the filesystem's actual positive progress. This ordering keeps every
intermediate kernel safe for callers that advance by bytes_deduped.

The paired fstests update corrects generic/517 and adds raw ioctl coverage for
zero-length and mixed multi-destination results. Both tests pass on Btrfs and
XFS. Installed duperemove exits successfully on the measured corpus. Installed
rmlint does not hang or silently over-report; it exits 1 after the final
unaligned tail receives -EINVAL, which is recorded explicitly for review.

A current-source consumer audit supports that ABI choice: duperemove completes
the request on a non-zero status; rmlint, bees and jdupes surface -EINVAL as
failure without retrying; dduper and xfs_io stop but can still report command
success. None retries, hangs or risks data corruption. Thus -EINVAL is the
only truthful result that also avoids exposing successful zero progress to
deployed duperemove binaries.

Matthias Goergens (2):
  vfs: fail dedupe requests that cannot make progress
  vfs: report the amount of bytes actually deduplicated

 fs/remap_range.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.55.0

