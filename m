Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34B19DF4F;
	Thu, 29 Jan 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697187; cv=none; b=BSv7jmbEASXSkaYeI3tldUYV0dmgAKCDeG0ThvgfrcbNEUPzP2LOwuTlk1RfCW2nZk5UaJdSJfHf/kliadiJfCxxxgEjRERLBh2cp3T4Gzdy2b5oSbRfY72NxePXh8mjPiQ1ZEO4yQS0UbFSFoJWFUXj2hrBk3bQfJDluMVJ6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697187; c=relaxed/simple;
	bh=lqWnJA+MbaR+9HGsECx8lJveRfp3JiHKjdrApTzN92Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dg5csUfJQwEsejfxt+TPq6vW36a0bbNAEjFSWRiL9zBTa1V+ZNAXjhVh7dJ3ZssUzY4M6ZTsygJ5PAx6aY3lqEP1o4TlvE0lsJpFtt8w0PscDwQoGOSZU0pUiaXpFQuYpcjq9FiAz85A5/7RwBH/XavafVA2cAQhaHsVDD9gGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuDY1gGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuDY1gGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A4C4CEF7;
	Thu, 29 Jan 2026 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769697187;
	bh=lqWnJA+MbaR+9HGsECx8lJveRfp3JiHKjdrApTzN92Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuDY1gGGfyfTdGqSArI+lzpeouyMxWPUE5yaWiBmhbFxBydM5C3sbc00HmsBCIaTj
	 8RxVw7qHGQp81ielm+nBEb/FXkr81/adOTL6VgSYhTwzhNgNHul9NaZg1lzwPv/vUf
	 wxcyBFmXu42I68e+YIB2RXezJBMjfvliVfrOL894GN9XGbvc4o5PlAS3Zf0f1BdKrm
	 1AEGA7ROQrpIeYUUqdUJl0avFUSGp8nHCQmX6UoMDLx7qtwp3eLKJTbd62dFZ3VdlQ
	 cRrwmigxXYOgn4+YGdPl/Tmq9StS53L8/X79vGM7uFmTdkgWpiy4XSGLhIV4IkkbU4
	 s7opmuayntkTg==
From: Christian Brauner <brauner@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
Date: Thu, 29 Jan 2026 15:32:54 +0100
Message-ID: <20260129-erwogen-vorfeld-85a7dd7df060@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=brauner@kernel.org; h=from:subject:message-id; bh=lqWnJA+MbaR+9HGsECx8lJveRfp3JiHKjdrApTzN92Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRW58+239XEx/U65lFk7a61luaHnk/as+f4wT9rjz18/ Ls7vE5fqKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiG4QZ/pl1X+N3nX2D5/Bp L5e7Z5Y8d+7lkG7LmP7iq9uM7Skc894w/FMwFkquklp48tqU4MvpG6ucHvwUr6/OMf+2drpUsK/ iGnYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 13:18:57 +0100, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> 

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] rust: seq_file: replace `kernel::c_str!` with C-Strings
      https://git.kernel.org/vfs/vfs/c/40210c2b11a8
