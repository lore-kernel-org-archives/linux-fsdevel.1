Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509895;
	b=KyWaMHzUvtkyVpRv/NN/OgPUIjglqzviAH9MvDo116Efw71EcbEP+sU8GjjdCJwt0VyO
	 OEQ99XLzMTJeFl6G0M9oSSvaAAarRJ2+vihsrC3EyFec2rwxEqBWiPhOEgbsvivaZIWAN
	 +CUz+6Ak93REbiDRwbqh8hXBK8ypfwaAtXWyxLmRfTzCX3KgHA7QBlhCZuvO92xFzExS2
	 MkXIhMzRfuM3j2Ic7WtnLl7pZjw0zAYDAWyto212Hd433NLr97wUa1x64f7loEW3ODiCu
	 mKq1OF5ydGEJ57petbLUMB0+3dHF6MH9Z0wkOdVO4B/1WDaPsy6fJL9r/J5oS742UzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=elwXiRCfgreMBRymobwx3IbDMUTz5KC/o5TzRKRmPAk=;
	b=0vXwOGuo+kTO6+ULT5wxFHRZfEeH4awjOgAhIK4zApa1z7VebvUqOt4P9z+ooa/MilrW
	 mYh5D5RRwR6wIqLCPxBUpMhNJ20uUl65lgBMcx7T8mUPwo+oRBceuRPow9QC60bqs6Uok
	 XK2Kj2GxM14oQBTI08chrCm2nBB6eYliQir4JfF2l1z4vfBh1O0xN/XdZUdWB5+YU388C
	 vhko0xPplzAJcwuSXdzb+2vTkBOhYWILgmMH0lI6Fv+qz8PlkNaLg96lJNi+P53pEVjZ7
	 7dUf1iZPjM8rkBT0tqqOX05+yZBCbz3BEH4MElJvVc6neG54sqYSYB6g4C3+6LD63VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KC+yUsDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73102606A31C;
	Thu, 12 Nov 2026 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KC+yUsDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB41F000C4;
	Thu, 12 Nov 2026 18:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509895;
	bh=elwXiRCfgreMBRymobwx3IbDMUTz5KC/o5TzRKRmPAk=;
	h=From:To:Cc:Subject:Date;
	b=KC+yUsDlDrOUZnIP1c9RvMynURJqoWO6B6KAUPOiDK5SQnFLN9x2aiGnfR68DTvYH
	 F89dXdqnJyLAPkOBRAlhhQfE3om4e5dFexkJ4zLBfAphUW3lkLAVkDpkKe473wYZyg
	 VFHHum6zxzRbdyZNgRNqq8KsOkEU+A3XQ+BL6v4pVv5eFaJhC7H0ebExtWrf3bSuAy
	 wCpPqcjsJjU9/nh4YTLsIH6LMm9OOmbw/7NkGPdKK9lqD0KoJ9NxP2m7hr8upDhaTS
	 36KNyQpre3MPyxT9eRAAt8d9UrY1MRwxGfqVoKypQKi+UQlR5hggg9McMpUIo16E/I
	 cGXJbKCzDTmmQ==
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
Subject: [GIT PULL] Rust XArray for v7.5
Date: Thu, 12 Nov 2026 19:57:45 +0100
Message-ID: <20261112185748.8877-1-da.gomez@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matthew,

As mentioned in [1], this replaces the earlier v7.4 PULL, which missed
the merge window. This PR is rebased onto v7.4-rc2 (no changes), for the
next merge window (v7.5). It has been in linux-next since next-20261102.

Could you let me know by v7.4-rc5 whether you can pick it up?

[1] https://lore.kernel.org/all/20261030101626.0-da.gomez@kernel.org/

Thanks

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/da.gomez/linux.git tags/rxarray-v7.5

for you to fetch changes up to 29f1617aa1dbd0803736403cd63c4965873fa621:

  rust: rxarray: add rust xarray support (2026-11-12 10:14:36 +0100)

----------------------------------------------------------------
Rust XArray for v7.5

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
been tested with the included KUnit tests and doctests on v7.4-rc2, and
has been in linux-next since next-20261102.

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

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

----------------------------------------------------------------
Daniel Gomez (1):
      rust: rxarray: add rust xarray support

 MAINTAINERS            |   12 +
 lib/Kconfig            |   11 +
 rust/kernel/lib.rs     |    2 +
 rust/kernel/rxarray.rs | 1407 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1432 insertions(+)
 create mode 100644 rust/kernel/rxarray.rs
