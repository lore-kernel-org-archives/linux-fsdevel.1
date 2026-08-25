Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A93DAAA7;
	Tue, 25 Aug 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646563; cv=none; b=b7dsZmOoZtfo/bwqaQ6hFYHjLNArolM3IEKqKuoi306Qg2am3uccWugNhohfmYsoJ2z9+ay8s2mT9zviJdbQ9MQUCEFQmxWlEiGKfN5I1HPPR91EYc5aqMx7a4alPr0YdZrvJ4jeRINkJ5GS3tiNkTwidGYEu0KdIEZdzuA1j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646563; c=relaxed/simple;
	bh=PUwz0rcB/GEzqbhWjChtMMjdkhpEOjvbDUv94lR9jDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=es1xo5cwKxnl7qJj5yJ4sDRHVEfO7YBGEEXHineePrI2SjSP8Iw0PiQr3tUWnjjzVT33PAnOFevpBnSfBEg7z4JlL8yQ99IlTgB+YMMeHkL2Cy7ipPyY6Z1WVj8s8lvW9B5HHIn7gaQOgAhZmJ4rXGehaS6ZpIpAmFtG+U1TIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hny1BBSZ; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hny1BBSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787646533;
	bh=fyyCd2QK4767vB8nvv96/0lxDJB4hf/PZ9OLH+y8J6A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hny1BBSZVPyzWpJr9NNpkpMQXRsMDv69yceZ1pUpepKW/Ti/IzbJwTKxrIKL8u8NY
	 0ZzSDO6zh+pVLcsMesNlcxYYJZ/r8Jb797ENFZz9jC+GPwcw2l1tXVj4tW+XjGqgIZ
	 gKg+j3FmrT9FRR7iMso1U4LuU9XZgu1G57DnbPRs=
X-QQ-mid: esmtpgz13t1787646514tcb5ca6ca
X-QQ-Originating-IP: LQwiSZo/vU7WHZqK6P1hPMrkbZwJQsKcsoduAZv3dSw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 16:28:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1693483800294911836
EX-QQ-RecipientCnt: 5
From: Wentao Guan <guanwentao@uniontech.com>
To: guanwentao@uniontech.com
Cc: hyc.lee@gmail.com,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: treat any nonzero dio zero-range return as an error
Date: Tue, 25 Aug 2026 16:28:32 +0800
Message-Id: <20260825082832.4009891-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260825054659.3967694-1-guanwentao@uniontech.com>
References: <20260825054659.3967694-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: McJfg7Aee/FZrsE4JnIV5JTw/+72crc3TkhJbr/CcZ8ThM1SPBdm2nQg
	a/95P7+Sxcyj5bgWRGCX792XemHgm1b6ycpq/XmTAGU0A8I9kqQqRec5O0aUyCzYIPFc8x0
	XHh/izCRDSxGx0j0EMxNDEUwKxrtKllsn2WgF14VULYWf1Calg35ik1YqrFJnzE8gu2cCwa
	nsV2fvD9yEcALmx9Cd5nnJoU7zoYZzvpkXztJAHKqg9qM8P+DYiwq+erlDTEeb1Vxn4kQ8n
	AVCfUyHo+Q+1bdVVwdfM72/yxOjAjeTJoGkAuYCjSoUwdm5cTdvFSat8ZRmFVRm0aCWyPwm
	/+hHRsZQSwtVk0CuQIa3e9ylHeeXuYDzl/SzSJUBtFfoJ4dE7hioLhFfIo2D0mvhCvhJ21l
	ieM0zR5R8cra3eGHPxafEnKiq27egmTE1zQKrhO9Z6piBhDKB88UKtQ52SGH2tC+JWaF/u1
	vubQDNenPdBFXe7KG6PsXNmyRhJTHvNEX57JRzSqp7POhfPHGRL9DBpbVcGuY5+SIz5eNb8
	wqESEpYyizSJZwHfI+JhTL96ZXvCRZchKPLBBY6+H4P1L16qKq1o/guWmxW9IIR6xHxmCHW
	Kuq6vq6dfYltM0yQrE3JNDh2Z2Z9p2ifBaetrmfG6Ouq9hw3oOJI2ROHBXEiVx/pOqmyGmU
	tif6MOVU//gg9+NNvUNT0TmRXao0JkguJoPaT2cmM5zzEy4k8r7Hjpy8EhDlLqUN5TlhWw7
	SSRFwzlWBW2JDHkynyrzLrPRRdyaDHK8DzxUQNHqXp2MtloDphW7LmC8Yps4g8slKod+xti
	jASZo7cMpWO5lyRHMknaxf5FkoAhtjbGJJIPHCYRGkyxo6KaYM1/Kzlc0yWfFTHDFwpGino
	iEK2cVJWoee/pogOUx9RoblfwAnujMNXgrZfO44DPicgsqqm8NcE+stLcddidIOMlX8oFSr
	Sr1jLVW2QMCmXnYYfiWZzAaSTQiaRQRn/BYEBwd0syDaGX4Kq6RZux9CzFLeRn7S1Qg1htf
	WTZKaLVaff1KJyreXPqQiWa11YRQjY5rmcRLu3ITeYJvkumkVIH28rT+lj18Qkby/VEbzOj
	w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

NOTE this here need also rollback the clusters that were installed in, 
and taken from the volume bitmap for the failed hole: leaving them mapped
would let a later read reach unzeroed clusters and expose stale
on-disk data even though fallocate() failed.  Punch the allocation
back out of the runlist and free the clusters before returning.

But I don`t know how to easily imply them, anyone has idea please let me
know.

BRs
Wentao Guan

