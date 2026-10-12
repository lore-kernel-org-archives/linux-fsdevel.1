Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443E399340;
	Mon, 12 Oct 2026 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806121; cv=none; b=WcoVzIWkkiH+kEUUrr8OmnezYIDAea7+8SKXCYTq4EmoEWAtRFvVgKUrKTh77QvMkuoB6mIiWU6FxW2CWvy2lonILQuFURHT6E2O4g7iLWu4CuV1ZQM4gPm0f6/IA+72GIVVEKW3sIy4pBLKcjKePmekVhRP0x0EYc0+DdxLa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806121; c=relaxed/simple;
	bh=ATvL8+jGoCFF+CbvlDbPWvSLChLAja5Ob6x7FC9QxVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NABDbrnyw2EmXkwDMWjmSIrHXeDPzLorm/6rZSlT4ZeG0pf/L1TDWf7LVZHU3o5v2kAc1t8NgIXsl+Ky4C0hUfILAaP/vzsNXkU1t29IT26lVRXxCB3iZKOXJTCp9KXDN6iKeOTJ+GxQs2QIZLwePckRFnLf3tTL/+b+V9I0X7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n43wZqvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n43wZqvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBB01F0089B;
	Mon, 12 Oct 2026 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791806119;
	bh=EFBfQFk5/U3oNT5PftLrBoxKpWYLq06VaTtaCGifA+Q=;
	h=From:To:Cc:Subject:Date;
	b=n43wZqvkpRiBHTT8srVSaSF0QkmteVpPPVz/AjMHgwTfz2Hhd0T8eeE5NQjiOdjcU
	 p8tgxSiKBAyVs9/yTPLNCJLwyvV9diis+mZSfSgX0foXGNit0XJ5Mvw7k6f7nD/Akd
	 62rLWO5ZY8lH0rIcmp+ZYjidpWABrGpE3ZSEFu0GE2ZnQmwmy1K7CbwiuoBwssBKok
	 jGXcHbMh3mf2ZR9xabtXfJRDYToLQa0Atye5wmuRnNaXO+Shlb8VEV6ZysUnORPkkX
	 ZFQp6ClSZrEsUcFjePPmIMOafuD419/ZMuBV5siF5ynAtyw3yq5R3SAjYc/gIl54DE
	 lhPI+9KfMuuRg==
From: Daniel Gomez <da.gomez@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Daniel Gomez <da.gomez@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Corinn Tiffany <corinn.tiffany@inria.fr>,
	"Liam R. Howlett" <liam@infradead.org>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samsung GOST <gost.dev@samsung.com>
Subject: [GIT PULL] Rust XArray for v7.4
Date: Mon, 12 Oct 2026 13:50:26 +0200
Message-ID: <20261012115028.73246-1-da.gomez@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matthew,

I'm sending the Rust XArray for the current v7.4 cycle, although it is
probably too late for it. Just let me know if you need me to resend it
later, rebased or under a different tag.

Thanks,
Daniel

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/da.gomez/linux.git tags/rxarray-v7.4

for you to fetch changes up to 4ce73d98a0a6e5bba46ed1fc9a61511bdccea776:

  rust: rxarray: add rust xarray support (2026-10-12 08:36:28 +0200)

----------------------------------------------------------------
Rust XArray for v7.4

Add a Rust implementation of the XArray (rust/kernel/rxarray.rs),
introduced as an experimental Rust reference implementation [1] of
lib/xarray.c, as discussed at LPC26 [2]. This lets Rust users, such as
the null block driver and possibly Tyr (under evaluation), experiment
with and evaluate both implementations.

The goal is to evaluate whether Rust helps with the most common class of
XArray bugs, misuse of the API by its callers, such as the long-dormant
page cache corruption that almost blocked the LBS work [3]. The RFC v1
cover letter has the full motivation, benchmark baseline and
roadmap [4].

This initial version supports store, load, load_mut and erase. It has
been tested with the included KUnit tests and doctests.

Outside of rust/kernel/rxarray.rs, this touches:
 - MAINTAINERS: new XARRAY [RUST] entry, maintained by Daniel Gomez and
   Matthew Wilcox, with Andreas Hindborg as reviewer.
 - lib/Kconfig: new XARRAY_RUST option.
 - rust/kernel/lib.rs: register the rxarray module.
The C XArray implementation is unchanged.

Link: https://rust-for-linux.com/rust-reference-drivers/ [1]
Link: https://lore.kernel.org/all/20261009212431.0-da.gomez@kernel.org/ [2]
Link: https://lore.kernel.org/all/A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io/ [3]
Link: https://lore.kernel.org/all/20260923-rxarray-next-v1-0-92eedf185649@samsung.com/ [4]
----------------------------------------------------------------
Daniel Gomez (1):
      rust: rxarray: add rust xarray support

 MAINTAINERS            |   12 +
 lib/Kconfig            |   11 +
 rust/kernel/lib.rs     |    2 +
 rust/kernel/rxarray.rs | 1407 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1432 insertions(+)
 create mode 100644 rust/kernel/rxarray.rs
