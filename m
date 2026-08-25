Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305252ED843
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666386; cv=none; b=X/GfyfpK4Tk1TaBtvPYvUyl8u0Y8koAJ7xcGjE3pTM6H5WRrrjtDFrml1Q2BMGM8hNl1xN+X++1iIsWdhL01KqpRU7DkOoiDktm+cbpB/QnG6zi32bvUzByueNmQmfZVsJC7Mog/UKO6uxeDTvG+J6nfAhQwVW7VRVwOnEDtxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666386; c=relaxed/simple;
	bh=ysqSK1QIN259yF/rvMTpSu5Iy2hZUL/VxDsPUitylhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iysCfLErnocQLl1UFvqBdIq0S/9Fd9ZA9gbnucPJsq/EOwbDUO1TRt7hNdoNaGw8hfBTrSJGvO0sPoqXmLeU4ZB91f0YLDc+lglYAEAAs5giDJHNn8EAwBWjUiyPYKlAvRSAp8HMk9JM+I+WN61YI23HOEMrDMC6SyydkkhGGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hwi1uPpi; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hwi1uPpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jh
	YyrzUX62FbDAltEDQWvpfiaZUa/DcGQ9ZO/nEs2sE=; b=Hwi1uPpiit5G7KJJJ6
	y3ZvBV5h/S1GjaxOG65mF2S28UjaYnynAgA4LDyDjBM6CIKVsA7emlzYiAdtM/bf
	3wjcqWRnrMscbPJ3JWNrusMiAkhcNDLbvofqAteN328EH+QRi3cCsf7GScinhC6D
	YmMWr71vkuD3RgKhzeRX11b/E=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_xdgn41qRT0JDg--.32073S2;
	Tue, 25 Aug 2026 21:57:53 +0800 (CST)
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
Subject: Re: [PATCH RFC 5/7] coredump: add COREDUMP_CLOSE_FILES
Date: Tue, 25 Aug 2026 21:57:52 +0800
Message-Id: <20260825135752.985512-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824-work-coredump-unlock-self-v1-5-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-5-48fd1cca7eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_xdgn41qRT0JDg--.32073S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF45urW5Jw43uFWDGF4xCrg_yoWfKrc_Zr
	yj9a1xG34DCFs2vF48KF4ayrsFgrWfCF13AF15XrW2vFn3JFZ8tF90gFyS9r1xJrsayrnx
	JwnFvF4kWr43ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUmLvJUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5wH9CGqNn2HmNAAA3Y

On Mon, 24 Aug 2026 17:28:19 +0200 Christian Brauner <brauner@kernel.org> wrote:

> Tools like systemd-coredump walk /proc/<pid>/fd and /proc/<pid>/fdinfo
> and some use pidfd_getfd() to preserve files of the crashing process.
> Only the coredump server knows whether it still needs the descriptors.
> 
> So let the coredump server ask for it. Add a new COREDUMP_CLOSE_FILES
> feature bit. If the coredump server raises it the kernel drops the
> descriptor tables of the thread group right after the handshake and
> before it generates the coredump.
> 
> COREDUMP_CLOSE_FILES doesn't work with COREDUMP_REJECT. A rejected task
> exits and closes everything right away anyway.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---

I don't know if I was the one who initially raised this requirement or
issue in the community. If so, could the tag
'Reported-by: Xin Zhao <jackzxcui1989@163.com>' be added?

Thanks
Xin Zhao

