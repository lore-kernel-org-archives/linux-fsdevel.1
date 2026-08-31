Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D73C81B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163325; cv=none; b=NgjH4SY2meuyjquiI6LYt+dRIka+BX2Z+qxlvZrcJNh3HwV20AseROB738bD6LzKwn5ZIFJDXL0CXajXbKxBuDcFWqwYA5dzH5hVMvDGkQYfwSlivv1bfBTvk4RGcgpY3EmmLsGwJGht6w2dEV4h8OH0AjkfTbIqMnrY3pmQeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163325; c=relaxed/simple;
	bh=n8RtS83wPJaqfk3MTmOaK3Tbh8DFBcB/qeF8hc/jM2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WwygpQc1PgLTylk82zF2jS97+GxmWnIran6y+cawB5Ahbw/bOcP+deM7XJkN8C2vAweexqifXgd6vovGEbU2xNpUAToVFVVyZTmwCw+P1Gg63s9Q/qZuyXi96GVFROZMfXlv6mxv+DiEo7kAA+iwgLFls80OqIVy9F8464rIjhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb2stanz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb2stanz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799F81F000E9;
	Mon, 31 Aug 2026 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163323;
	bh=vX5WHaaM0oPCvzWMESCV1kE+YZXtsV8CVMZTrMCCrf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fb2stanzsud4ErYh+i9f90ru+YaxVGZUkQ4EUs13uC02mlCQLT7XDBDabdc7OY1m+
	 dBVHZnEgazjqHt4iv5Mdik5I3qpx51QE/ICS6kgaJl+yucBXrcI/kARBcIphrF8SCK
	 28aULiHIDEjJFr1LBQQa4wErfK7qJnFw93MFO6kYhrDX5tooBrXah6Uy5Mg1rdixXW
	 XJVeLrnxY358JC8ANeNuK2i7LS98NHjK5iY9Vy5AaFNcOQE2dq+/TKm4cULg5bzfXC
	 KdtE4kPImZpCdwArVKq4MPQWoI/ydvz0f0VuyOVISg/gv+k9BL/A/+eKA0teg8Aycj
	 Bwo5KC29jny6A==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Manush Prajwal <manushprajwal555@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260813093404.1278-1-manushprajwal555@gmail.com>
References: <20260813093404.1278-1-manushprajwal555@gmail.com>
Subject: Re: [PATCH] fs: fix comment typo in bpf_fs_kfuncs.c
Message-Id: <20260831-kauft-sparziel-benannt-783e78f11572@brauner>
Date: Mon, 31 Aug 2026 10:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n8RtS83wPJaqfk3MTmOaK3Tbh8DFBcB/qeF8hc/jM2o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNNfl1vSonRnCrQqe0btRU9psn1+8++Gpy5zoDmztBm
 jU2ylPCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayvYDhf2mQ8F452SitWxwT
 9rxaVMz0ocA8UGP+zKurWFwbFge1yjEyPCw7f9VFz7xtI0N9pMhVgaXTNkc8X5jNGjlj4ivx+Z5
 fuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 13 Aug 2026 15:04:04 +0530, Manush Prajwal wrote:
> fs: fix comment typo in bpf_fs_kfuncs.c

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] fs: fix comment typo in bpf_fs_kfuncs.c
      https://git.kernel.org/vfs/vfs/c/42c9faf2d868

