Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E773FAE19
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665849; cv=none; b=JQ+l+uj1FiBc1czc0MNhLLGR5ivajXYfumKIngMi+WYowxGcU5r0MIHYsKVn5l6vziOTpDINPUi1XYsVt5qRCy4lmow+O0Kd1PVy3hunuDlMCGKNgJPZesVh+jdMftSvns5nSCiZMqXUKGtQxKJJEwMRs+VbuU1gInqHmEeo6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665849; c=relaxed/simple;
	bh=0QmyQYCUiutTy4aT4JdDkKAZMrcfTgYvqsO/xot9z7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ5OhYRRzWiil7g7WSFOiRqLYWxm6M8G3yaD6ykSuSwzz4ygN4Ht+mT9IL9wpvv1D5hP2/hkANgMkxjf2pjCD3qdBMxUgv5Xl1h7kP0wOWEgbRpDzj6KPVCR5uNiWuxRtBm+DwBUxNzyT08HkTL1QToyGkBvWkb/yh6A96KNeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K9yF4osK; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K9yF4osK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0Q
	myQYCUiutTy4aT4JdDkKAZMrcfTgYvqsO/xot9z7A=; b=K9yF4osKINWng+BSG5
	0a660KQ9OVlaRJXvODUx1fEigzy+BTmdESIhuro/mErSs0ARJI3cBc6i7Fca59dM
	KKHHSEbWy9PeP/kDJleL6LYoPORi2kcHfb3hA+qLNWtlEnue093lXBqZ6LRLNQU0
	WEItlaGtoiTUQArnYknXBsiHo=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXECR2nY1qFW68OA--.11457S2;
	Tue, 25 Aug 2026 21:49:43 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: axboe@kernel.dk,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mjguzik@gmail.com,
	neil@brown.name,
	oleg@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
Date: Tue, 25 Aug 2026 21:49:42 +0800
Message-Id: <20260825134942.979297-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXECR2nY1qFW68OA--.11457S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRnYFAUUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5xeCjGqNnXfIYAAA3b

On Mon, 24 Aug 2026 17:28:14 +0200 Christian Brauner <brauner@kernel.org> wrote:

> A new COREDUMP_CLOSE_FILES extension that allows a coredump server to
> request that the thread-group close all files before generating the
> coredump.

I indeed couldn't think of a way to address how to release files earlier
in the coredump pipe mode in our project, although I also knew that
adding a step in the cump socket case was relatively easy. Anyway, being
able to support early release in the coredump socket is definitely better
than not supporting early release in any mode at all.

Thanks
Xin Zhao

