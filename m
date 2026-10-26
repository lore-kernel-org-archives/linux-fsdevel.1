Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002797;
	b=OU51OjrYfVKfrOn+Ep4moJQrMTi9/+ebK+AlPwJbycoRIlNFhLGamqkJ/XSENOIkZ1W3
	 RZiXfbf8tRiT+9EsQKZ7CE9R0ie+bwfMrGdc7Zqk0CCE8jXBu0+G9A0YT3JitoAzzjD9r
	 CXeLTIPqbVE3W4lzQxaUGqEbF4YQtxwxmgUhWEV39MzQA2Sgl/sSKVHl1J5pJhU8wTtWp
	 aMtVuYgj7f8ZGw/VOtiLFlJIkzh/ssJGOCYEAfQITYErUCFRrSY6dlaJFd5I2QiSzhoJJ
	 uS7KztN+xXt6Oy9MnBgCKqYQtFE+xING7CsW6T92+2QUp4HJMTrRUBJ5v1DF4Yj+ICg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002797;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 X-Developer-Signature:X-Developer-Key:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IDp3KuAS1tro98BIfEQGyxBAwx1zOi6kq5PMpMaxJjg=;
	b=exaKtq8UHdTVf+MjL2RhCSh9irltUTUZY5NPiZXDiC8OcBbEb8Wl+Ia9WPK32Zi1TDl6
	 3F7GSScD6gNx5EgYzKB8keglkiziug0rIgBHUtcSOSzlzvzbLb96OYmUzvr7GGgrlIE6M
	 zPffAUaLucDl/X9JFtLZBOdCOWXW5KH4GjOwnVcnQLpaVGY1f7Lmu6IUOp9G8LtyZa3Oy
	 UdDd7luseFZzERDxXyH+nP2NCP/Az0g5GQuj7P/X69pfViGHRkIcg2eNbGyIFtROKzP64
	 YjknCJH5k232c7mJ/tpjchJCyQNjtEZ+GbI6moG4Anh3rPM+zc8AE6gwZIDQOruN+uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9VHz9Jt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E61606A323;
	Mon, 26 Oct 2026 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9VHz9Jt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A841F01825;
	Mon, 26 Oct 2026 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793002796;
	bh=IDp3KuAS1tro98BIfEQGyxBAwx1zOi6kq5PMpMaxJjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O9VHz9JtYo98sgJWsBa8YuuwzTFvQS7xl8hvVKP4mprLg/Mkx8tnP0ZZ9mmqkUIu8
	 SQ+/J4/iNCUEPx+cSsEkQLGcDX2FtpN9cIgLrDUEkITF2X0h4opy/iLo0+t2QLAh0H
	 Q6AYwB//FEDbUgEHGo3ecm9NWxnw3m8bqFzJKnblD686i3ADKPr3mqc8M9zf3T9Skc
	 +hZjk1dKf5eab8JHzVFEYGa3yKg8lTtXL00V/m6uEzic35JKAbMi8sESURXbFqCDne
	 dvqAkQgCLMarAW1jyTBz64FnQ6DrurShCpc2hay0T5d5aTHaEG8x81gPMICA4JjAZ/
	 FtugDkyI+BZHQ==
Date: Mon, 26 Oct 2026 09:19:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v7.4] vfs keyring
Message-ID: <20261026-bauordnung-gestiegen-buden-b22e45a2c1c3@brauner>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3635; i=brauner@kernel.org;
 h=from:subject:message-id; bh=c8YDQuzod5d24jCN1aOg9riFbzVfK5JShO72FagV3Gc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd55rv/XJ6PqPGk/vtNUfEBDlj3kms62+pUwmOerwlj
 2fO5M7pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMROcDIsE/ny8Z1BakV5dM4
 p0xZvvzlrt0nzDO8dNUuX4qVPb3pyWpGhkmiSo+yRfZ8O7e6MUnY3NNo5ne1yV9ibMo/1l/77Mi
 /nAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
 <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
 <CAHk-=wh0gCvsC7A9z_H7her218kSCmd16dqtd9uMfO5ZrSvxLw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0gCvsC7A9z_H7her218kSCmd16dqtd9uMfO5ZrSvxLw@mail.gmail.com>

On Sun, Oct 25, 2026 at 04:35:56PM -1000, Linus Torvalds wrote:
> This explanation reads *very* oddly. It doesn't actually explain at
> all what the patches do or why they do it.

Ok, sorry about that.

> The only explanations about what the patches actually do are complete
> and utter nonsense. They claim it adds some kind of "well-known key
> IDs". That's complete BS. There is absolutely nothing "well known"
> about any of that: they are completely new random key IDs that nobody
> has ever heard of before, but that are meant to be used as fixed known
> key IDs.

I meant "well-known" in the sense of "fixed ids" that userspace can rely
on them being fixed. Certainly wasn't meant to mislead. Ok, here's my
rephrased proposal:

---

The kernel has two keyrings that userspace fills with X.509 certificates
at boot: .fs-verity for fs-verity built-in signatures and .dm-verity for
dm-verity root hash signatures.

Neither is linked into any process keyring. Hence, request_key() and
KEYCTL_SEARCH can't find them. The only way for userspace to identify
them is to read their serial number out of /proc/keys. That is not just
a large file often the names can also be reused and appear multiple
times which allows forging these keyrings.

This adds two fixed special key ids, KEY_SPEC_DM_VERITY_KEYRING and
KEY_SPEC_FS_VERITY_KEYRING next to KEY_SPEC_BPF_KEYRING. The latter went
in through bpf-next this merge window.

lookup_user_key() resolves the fixed key ids to the two keyrings. So
userspace can add a certificate with

    keyctl padd asymmetric "" -10 < cert.der

and seal the keyring with

    keyctl restrict_keyring <keyring-id>

without looking anything up first.

The following changes since commit 1b7415bf70be95b9a1e7e87d544867881065613f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc2 (2026-09-06 16:17:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.keyring

for you to fetch changes up to 503b65da9a7e5447d91222f62399522f2f62a0fa:

  Merge patch series "keys: Add well known IDs for fs-verity/dm-verity keys" (2026-10-12 23:37:42 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.keyring

Please consider pulling these changes from the signed vfs-7.4-rc1.keyring tag.

Thanks!
Christian

----------------------------------------------------------------
Andrew Halaney (3):
      keys: add KEY_SPEC_DM_VERITY_KEYRING
      keys: add KEY_SPEC_FS_VERITY_KEYRING
      Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY

Christian Brauner (2):
      Merge bpf keyring work from of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge patch series "keys: Add well known IDs for fs-verity/dm-verity keys"

 Documentation/security/keys/core.rst | 13 ++++++++
 drivers/md/dm-verity-verify-sig.c    |  3 ++
 fs/verity/signature.c                |  2 ++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  2 ++
 security/keys/process_keys.c         | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)

-- 
