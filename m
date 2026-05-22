Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50309367B64;
	Fri, 22 May 2026 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452418; cv=none; b=IHSbmZgy8RwznEUwmW6ZcTbGdF7+emlOVTPT4B5vLhl8hapcyXjStcUoa26dtVuegK4/rQnhgtMiG73PwkdUwXnUcif5dAkU0BKCgOVNvrLJBv5TLPb6Kk6Nmr988WiiZyr9fCwvtdjfD44SryBNsf1F2AcIFVPYwkZzvq6v4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452418; c=relaxed/simple;
	bh=pqcfrVKMzW7pHPbmJHUK6Mwi+lUai8sMn3jmozwKCNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqh2WsQOJjJICBa8jCxBsidUH9yoOlgZP9hTyT+Lws3IIog1Rkm4BUFLJ04hY6ofRvwvUehi3fDTpAMamlfO1Z+wCryDzaZ1dr184EJ3PjrlC1kBaCkN1L2dF07bdL6isxGLU2vXvDlbNN1FAjHt04HEoHSC0FHOk9ePlp9KIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzyFUw3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzyFUw3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28891F000E9;
	Fri, 22 May 2026 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452416;
	bh=43QoGzg3aGL+idkapD3qwjyb2kx8u7eSqGNKjfPfxuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzyFUw3dL2/EfRR35139lzTeamCyAbJz0ej0XYhD3E4mHBt5jIYlc12reQLZuZcfq
	 v/vb2O0C1somsTIuJ4lLcob/RzTFIA27820CKsuelm+rZZ8vWBf3gvKnrdLbl5prLw
	 t1jPv8hHRDWaLLhciIX+owIz4QQkZMohYbCu7EqfoO1W9AAPgYlY4oBY+VTX5iDZA1
	 6Qqrri8QEeTNUOQA3Veq1ruyiFUjG5mFE2WInkswX2+1hEqVwZBmGGVKz+o7mT+5EA
	 ntMVG3pOO6doqJwsnD76F7G5SOwYpvpr2MprdzxrTi62fPM5n8bwiFKv7y6yOjapTh
	 sDH7vK6x1BUPg==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fuse: reject fuse_notify() pagecache ops on directories
Date: Fri, 22 May 2026 14:20:10 +0200
Message-ID: <20260522-dickdarm-mischen-vielmehr-e2019651bc10@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
References: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=brauner@kernel.org; h=from:subject:message-id; bh=pqcfrVKMzW7pHPbmJHUK6Mwi+lUai8sMn3jmozwKCNk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJeP4J+PrYRzXlSXQg9/nW86dL3R28lXce+FhwfYLGx bQD0nv9O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCV87IsLj162km0WfLrV2O zQvhVPzdoMNX11Vjf1Hv51aGpuv2wYwMSyN+/nY4Wa5ZudHIh2fWBNYtOta7zh/6rHfjiOCv1CN 5PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 19 May 2026 16:29:38 +0200, Jann Horn wrote:
> The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> FUSE daemon to actively write/read pagecache contents.
> 
> For directories with FOPEN_CACHE_DIR, the pagecache is used as
> kernel-internal cache storage, and userspace is not supposed to have
> direct access to this cache - in particular, fuse_parse_cache() will hit
> WARN_ON() if the cache contains bogus data.
> 
> [...]

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

[1/1] fuse: reject fuse_notify() pagecache ops on directories
      https://git.kernel.org/vfs/vfs/c/ef5728148f16
