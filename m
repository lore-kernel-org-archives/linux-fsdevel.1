Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C640BCC1;
	Thu, 23 Jul 2026 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796653; cv=none; b=tW9o09TR5Z8BiLQsJZ3aji2cJCcl9YRmi7+txgTHPFojzDGAum2+54svF3KOpYqHA+RapZzxRtjVA5W8N0WSRLk1ud9oqFWniPXuvO3MG28gjzZsWfjJKPtwn+pdyPz2kqNaAMpthQURZCkGX8jLD18YgxuFhY0A9+NBbyVDfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796653; c=relaxed/simple;
	bh=q9UYMtcFTAlj3q9BvYtDEHZMwqsrEzT9TKZ26WbK8gM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UdV4cypCSaE9Q96h6iuObPjK4b7wr17tyVdB0KmG2QtE4HKRfZxaYnqMQnnh/m5XV6oGkZA9hlXevOyvYO4tFa3KHCQIiy3y3rwjnhBVCr+41OpeQvuj6FfojHJP3hMv+4Q3L7G5nzOPbzWYxAGUTXTX18HfYejeFOd19rb487I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbMVsamk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbMVsamk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502CE1F000E9;
	Thu, 23 Jul 2026 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784796651;
	bh=mvAeQ/aboL/suM2KJ1kBROY3Vx64rynQmXOOKIA6dV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XbMVsamkDpqxhEG8h45oJGFNpJbiHLs5+dFaNk5aTu0HhgKkdAQr1d2/XlFKfsuoA
	 smC6HK/AdJA2HGgDR9c673pNs43Edp+wr+4z03GNeLsJQxn1Xt22tPcoT65zwunUAD
	 QeGlBiZmitUyPCXS1cnPtk0XHAG7xhZ+4LOm4SsUPAOIC78HUJ1WR/0P6awSaYJE7a
	 hacksulS39SLHKao2vpvxalC4WcxXoxCCMqSwGm9s6dO1BV5s4KG7TKRP7cEx9jf3C
	 q6xRXeW5k7flTZB0ZrLn/LIVRdcAvqZsf2+daMwkgW8bAxexac2wNg+bRA2MNMJN3U
	 ygjCFI/TZ9uZQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, oleg@redhat.com, 
 mjguzik@gmail.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
 jlayton@kernel.org, Breno Leitao <leitao@debian.org>
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20260720-b4-pipe-unification-v5-1-9002a3fe5e6d@debian.org>
References: <20260720-b4-pipe-unification-v5-1-9002a3fe5e6d@debian.org>
Subject: Re: [PATCH v5] fs/pipe: unify the page pools into a single
 per-pipe pool
Message-Id: <20260723-unzureichend-vernunft-raven-b96f77bdd9f4@brauner>
Date: Thu, 23 Jul 2026 10:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-35fdc
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q9UYMtcFTAlj3q9BvYtDEHZMwqsrEzT9TKZ26WbK8gM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlXn3hwFiwV1IuX4Iv89X3q+eyvDL7LkRv7Z9zpiLcf
 sPaQrv6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcZGP476Ovw1+4QnDDqhDm
 lUcSBBWj4uUXNyiKT9n6Z+WFwBl2Fxj+8G9avoJ3Jt/JPF79J0eqnlUwV/zznhbIynx3amRhfHo
 bFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 20 Jul 2026 03:39:33 -0700, Breno Leitao wrote:
> fs/pipe: unify the page pools into a single per-pipe pool

Sashiko reported some issues with this which make half-sense, I think
but it's dismissble. TL;DR it claims that 6 excess pages per pipe may
linger (with some splice sheanigans) until the next pipe use (read or
write) or close. Sounds ok to me.

---

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs/pipe: unify the page pools into a single per-pipe pool
      https://git.kernel.org/vfs/vfs/c/bffc603d5fd2

