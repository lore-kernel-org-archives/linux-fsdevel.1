Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B836B07E
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024884; cv=none; b=tCKSnGcHGP458xjm6OLNvbFFvt1oF4B8RYLTmppR8LyXMZfsXW1TTp8A124ejWzuYT45+OKTACucRdBrTlI6CRNXEkVJBvZrVeR01qIRG6XUPAl/c6tDh+2vtQQX4nOnh/OcNcAVJtmETb72+lZhakft1o82dlBrpYsSvTCPWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024884; c=relaxed/simple;
	bh=PRIhoNkO9i7DFlbnKE1gCwvOFnoFhRJlF7dSHv1y44g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=INoIBdGHUFZ+FsdkbqurM350OSB4sxhQPp42+iAUzRsOey9jr24HDKi6N+kjbCwt7cOpSLl9SrXJ1IqxEzZEmkuFvEf9tFm2VIfbE3bnP1CFH7y14euKO7oeGgO+I+eq5IN/J7TjyYldxZ7om9sPF4ENWFMTAlqWYylgpBOX3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTWaqWpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTWaqWpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619731F00893;
	Thu, 10 Sep 2026 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024883;
	bh=tHIk8vOhYpLsrNaX6vZcT56D2RwIGvuM3EMpihec5hM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=HTWaqWpD21p0U7E9t/AlM9t+ZxVO3D+ZHFyiYCcJKmyr3OwSXLsuFDwVj7T5NYPea
	 L/8EQX3qF0l2bDO8zTIaa035xNxFybJ4i7ln9EmEwlkb7chQzEcv2LOeVWQ5Na+mX7
	 rCjXoNSaczmyNCH5kPQgaLKLrXBz0iauPPRL5GPWXTPMrNtR+sEcbQ4ILBGI2nJqe8
	 2gtb5dxVPYdUfLfA1KaiKCoxBG6Psuuucm5+B1zy8QzJHr+AtZWFVVsZplbHSbOdbG
	 0ftxIycG+yFfcB3G9Rfn+Jnq8Pn5YZjt1HSF9pJDK2wb4QBLPuv+8oac+M8KPPC850
	 Vhmx1TlAtc3kA==
From: Christian Brauner <brauner@kernel.org>
To: wenyang.linux@foxmail.com, shuah@kernel.org, jlayton@kernel.org, 
 jack@suse.cz, djwong@kernel.org, disgoel@linux.ibm.com, 
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20260904183659.B81CD1F00A3D@smtp.kernel.org>
References: <20260904183659.B81CD1F00A3D@smtp.kernel.org>
Subject: Re: [patch 1/1] selftests/filesystems: fix missing and stale
 TARGETS entries
Message-Id: <20260910-pfade-leser-krallen-16ce99947cb7@brauner>
Date: Thu, 10 Sep 2026 09:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PRIhoNkO9i7DFlbnKE1gCwvOFnoFhRJlF7dSHv1y44g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtisrns+Pg6fAtvPxnxs/W509nfT11e8FXt8Q3G/VTa
 2Q7JGYGd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkL4Xhr/ivD+6fGFq+rDjV
 JDlhyz6z537zLNh/i3fJir08cPT5RR5GhgdPj25ynBN5VEFujnbDu8Oify58yzBKuxG4PEjkviU
 7LwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 04 Sep 2026 11:36:59 -0700, Andrew Morton wrote:
> selftests/filesystems: fix missing and stale TARGETS entries

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] selftests/filesystems: fix missing and stale TARGETS entries
      https://git.kernel.org/vfs/vfs/c/d59ac79915da

