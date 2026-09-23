Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4B57EDA5
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177549; cv=none; b=jlXZbKl8hOD/ZnoXXuzkUv1I55mtdBjpz0xruB4IcQKjbLU0JITPypRwYYxW5a4/2BxbfpioLXb+T2v+R2KU7JD3ugr3i6dTHq8jKFdGN5vd3ZS9u7cYYWhNw0XK/KJSZQyxXPGYm77eY3YUGt6Tmz5toLK6rd4Lsg7qBZ1xebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177549; c=relaxed/simple;
	bh=mSR3f1gDPChfk7NMnvIsHTprfuzaYszs1yxvY+OqOhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIoPkRZztulk14YughNJqnxfTEr1SIF2c7w8P1ZaKx+DzZVw+L1UIttMRsZ2dEXx8IANqcI+3aOC0E97fy3hbwnwALmFs674GCsElDezI55YsWYMY8kADgBZgMt+CM7GywlCmKmY+Sd5Cgl723s+aefiKdkNrQ+8cYHVtfKRSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAgeQI72; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAgeQI72"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so5081095ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177541; x=1790782341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eizHbalFVOzT+I6Ooa3gggOLwA/JPAGjR3GiwZpUvKw=;
        b=AAgeQI726MkCk/oA1+gl/roZwc7xD+ivXB8ZSA7SS/+SvqCDzWUk+7PwsKc+KDS3OK
         +0nYdCrpyZFv3k60oBV09l33TyDItkH9bXLOmnU6MGEx9EIlsu39VgJfJZ2Yr0l/tarp
         RpeMwy/S5449U4QNmnHtlGHrauKlDPqlp9uJJIzZw5G5bZMUEBc+FuveLTU43f7Bj9yT
         xaHb2Cg4YDs2xOHwc28sVnK7g6qfuj1tx81JcfiTkz5jRZWwX9FganBAzow3Xb600PSx
         dLdg9TuheoP3R2o3B7YmotS22lwRt7Bfyo2A3qF8WmUbntKq+tMVRJN75xh/QJDWy/jC
         V/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177541; x=1790782341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eizHbalFVOzT+I6Ooa3gggOLwA/JPAGjR3GiwZpUvKw=;
        b=0Gv2jqj1hZq9pVh45+aZfP1oUV2Q4bhA46gkolgBR4B3HQmGf5Qw+lQxAnuDyghbHE
         s3+CuMDf3KRRtAL88ajlhsDTqhMUymrOKQllY0DMVzd+l0Je/pKbGIehUXmaRxfY6Gnl
         1FA75lCcXJI+lh51TNtvudbwRc/+06Tg+kuB1NZyGcKW7fHUqd3ogTX8B7T7CZuUxIoY
         bRE0uVAM8hESalXi7AwJ7fkc6uO5+nAT16Bm3MuvcqlJoI86s8wlCUwHGx+T/z1uew+i
         JAqDu0D96jOm2Uv8Nn7Jh2btE0JFrdtg4rsnqi63DElS2g2AWR70/0k9+eAl0VBHvdRK
         AyKQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1RK5gMyr3XMIPr1IHX1IMB5askIqeIGkgSpWE89sv+rQGen9FjElIu41MJllfZev7JNjfhHgs2+pebMSU@vger.kernel.org
X-Gm-Message-State: AFuF++lahQGQVXGemqx3/4qP2fTVmVRUfrS+mHOCY1NH0Tx49No1cVtM
	V+T1iJG41sdXNBiLig9RN4yuchDoxmt8QCKMNY0s/lPuxp7MSPeNt+N4xoLr5dKS0Do=
X-Gm-Gg: AYBFou0KrRL2XNvxYQpmTJ5EZvi+6dgyh6xG1N95vnE5IozLIPfob1iuOomVOZ6nAWh
	dJPqlOq/RHyAC/9XtCXNRgRzE1ioUhI/p21I4lj3qFIZ9rpgZdClfFWUXg5zFGVLqToF008XNQS
	k0FtM21RcEB9Gs4XsRPg6wJ42DrP6066+yqownUNrvtoM0eLbddvynyLQOB3Xdw/C+tWL4tJQbp
	BJxMZdS0+7+8vHS3jdSr7qHDqH29m+lnCAs122ld2Ni40hLuVkKP1YHIfYdms/i5kGJKi8JSdnI
	TyrMTd7KQsMuttqZmgdojcWQbE3Hp1Cmz0znVNGquc5oq1UoS7bUzldDQS7ib06LxKUkbOiCv+K
	qBSPx26foT7o0HjNSBrenbFgKZC01LIejVbkAof3VXmwq/oOYZoUWj2qlJNx2reSSxHrPS0LyBP
	yhxuwvqLgwJXKmzXL9yGF+Tb3o3VXCKVi4ATH+ArwDNRKtg2WSWp3XegyntQ6bF164DDvGtUI2V
	zgcpHm9t9ZMI+j2bTGyKKnsSloncoYbl2dBIPnfBPV3zArDNrAuUoFwhIqsGSJRrfCPTpY/ZTp7
	CHW1qqBDluHicOdQSPydsqVK4crcA6jo6Y8t4aUujkD7fUuqkvVHD303RddlONM=
X-Received: by 2002:a17:903:2f85:b0:2df:5b0a:33da with SMTP id d9443c01a7336-2df69dc8cebmr24623855ad.34.1790177540475;
        Wed, 23 Sep 2026 08:32:20 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a69f7sm13139835ad.16.2026.09.23.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:32:20 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	chenyichong@uniontech.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] isofs: validate directory records in isofs_read_level3_size()
Date: Wed, 23 Sep 2026 23:32:17 +0800
Message-ID: <20260923153217.777351-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cpadce3biub2f3lv5mnuegqpd5wwip3n67oe4xy3jujserdzfk@ynipz43pmoul>
References: <20260922140137.1768064-1-matthias.goergens@gmail.com> <20260922140137.1768064-2-matthias.goergens@gmail.com> <cpadce3biub2f3lv5mnuegqpd5wwip3n67oe4xy3jujserdzfk@ynipz43pmoul>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

Thanks for looking at it.

I don't see how it can trigger there, but I'm probably missing
something, so here is my reasoning.  With 1/2 alone, offset is always
below bufsize at the top of the loop: a record that ends exactly at the
end of the block takes the existing "offset >= bufsize" branch further
down, which leaves offset & (bufsize - 1) == 0 and bumps block, so the
next iteration starts at offset 0 of the next block.  And
isofs_dir_record_valid() accepts a record that ends exactly at bufsize:
its test "len > bufsize - offset" is false when len equals the room
left.

I also tried it, running fs/isofs in a userspace harness on level 3
images where a record of a multi-extent file ends exactly at the end of
a block, including xorrisofs -iso-level 3 output with a sparse 8 GiB
file.  Neither 1/2 alone nor 1/2+2/2 rejects the directory, and the file
sizes come out right; a record whose length runs past the block is
rejected.

If you have a reproducer, or just a hint at the case you have in mind,
I'd be really happy to look at it.

Even if the code might be technically correct, it's confusing.  1/2 only
works because of a branch further down that 2/2 then deletes, so I'll
send a v2 that squashes the two: move on to the next block first, then
check the record, as you suggest, with the straddle code gone.  The end
result is the same code as after 2/2.

Matthias
