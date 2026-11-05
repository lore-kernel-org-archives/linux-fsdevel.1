Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840398;
	b=CLV1clSf0FRblweiJ2fZT/kh2TfJE/+kXUxoNmDViXm/OisYLHolFwc0XJy33FAb+RtJ
	 vjnlnfmBoL6Uq9CY8dV9fKAG2UnmUrfEdoimNsI0mV0csrk2b5fvOJUT6Fth87/d/idSk
	 O+0/tkqkHy0PmhZy725jV6T6XMoGpLLBfqGKQSFgIZrnAsuiMIzKVQKVpvRgz0b+mgjBY
	 3HtWETqZj7PabFUkM3XU69SfQl+dmS40PS0TKzYigsvZ2I6OSPB2mlCmg/hXLZPZRS+d7
	 w95I+WJUyG7KhFjw7YTx0RUAEGA+ttroV+o0Tn53u0xOD7+H8+FFM9X/u2oB/BUApdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5ghn81JNo/X4bGl6s6oEWHPZ6Ik7xjUHUPnVmecnXK8=;
	b=WQeP7CXJGMXgT2EYvwYtyQYW+cz6L4a7rsq9CTfz/O9t1yBjD3BM6UJEcnCXZ0fo2IJ9
	 zwYSYUUn0LLn5EPvew2DJkYoxMgm55OSA4YxAGqoyy7XkhG3Aky2aTc73InObwDT+ncsg
	 sQB5AIdDG+oZbONpiUvIzm4PSnZ6z2bBpuBVt9p1+Jd+MoPr3jp/qdQhOqGdi1NNsAxfd
	 Z/CNKQYxcw8HABzGUrzjuQ3iXDP9QZiAFxt0Ft5ekUJTme+KZxHL3aI+p9Zid6PSmjB3J
	 YCisneEj+rNZRYcByWMPk5ybeZ8Gv7cAJ2pP9jT8tMCReMXMh65VwqSXLYzA5vxxxdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihPLacdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA4606A31B;
	Thu,  5 Nov 2026 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihPLacdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C81F000C1;
	Thu,  5 Nov 2026 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840397;
	bh=5ghn81JNo/X4bGl6s6oEWHPZ6Ik7xjUHUPnVmecnXK8=;
	h=From:To:Cc:Subject:Date;
	b=ihPLacdMqCNrFzO8n7joRxaZ9vap3HjXn/9/X23dw73mWTRIO++0cGYGQlSJtbysZ
	 gHaAGDNuzh4fmVsqzFzdbqfVCz3TuncksUYgCn7ThqS7yvfJWGqbJeQSF/ubrD9F1q
	 +8TLVfQ32qBcIcUX6pzkyV8K+hXE0YBuLshQ40lsioUV8uauGIEuIdfKO3xPluuKf+
	 yzCvHBSm/764ORRpJWvefLVbmmMYw+SMZ8PfhuRR2qKwioJZKp8XkD1VV3sjcCJm0A
	 i7YN4De/x3mhBEB8laYPLu2M8le27Svr2Ez7XuY7ZadYLnwoKLa0wCTSzFtMDn/YrN
	 OZuvdHZXDOl/Q==
From: Danilo Krummrich <dakr@kernel.org>
To: boqun@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	lyude@redhat.com,
	daniel.almeida@collabora.com,
	work@onurozkan.dev,
	ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	tamird@kernel.org,
	acourbot@nvidia.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/5] rust: sync: add WaitQueue infrastructure
Date: Thu,  5 Nov 2026 01:59:37 +0100
Message-ID: <20261105005951.756157-1-dakr@kernel.org>
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

Add a WaitQueue abstraction wrapping struct wait_queue_head, providing
wait_event()-style methods that take a condition closure directly.

This is needed for a (subsequent) DRM patch series to wait for in-flight file
close operations during driver unbind. The Tyr driver also needs it for "CSF
firmware responses and other GPU-driven events" [1].

Convert CondVar (and PollCondVar) to use WaitQueue internally, removing
duplicate code using WaitQueue as the base primitive and add
wait_interruptible_freezable_nonexclusive() for subsequent binder usage.

Changes in v2:
- Drop the already merged workqueue patch.
- Make as_raw() public.
- Split error types and use bindings constants for direct C calls.
- Avoid condition rechecks after success.
- Check the condition before preparing a waiter.
- Add non-exclusive wait support, including a CondVar method for subsequent
  Binder conversion.
- Handle zero and expired timeouts before interruption; extend KUnit coverage.

[1] https://lore.kernel.org/dri-devel/20260721151423.444175-2-laura.nao@collabora.com/

Danilo Krummrich (5):
  rust: task: add safe schedule_timeout() wrapper
  rust: sync: add WaitQueue infrastructure
  rust: sync: convert CondVar and PollCondVar to use WaitQueue
  rust: sync: condvar: use task::schedule_timeout()
  rust: sync: condvar: add non-exclusive freezable waiting

 rust/kernel/sync.rs         |   8 +
 rust/kernel/sync/condvar.rs | 134 ++++-----
 rust/kernel/sync/poll.rs    |  19 +-
 rust/kernel/sync/wait.rs    | 524 ++++++++++++++++++++++++++++++++++++
 rust/kernel/task.rs         |  16 ++
 5 files changed, 612 insertions(+), 89 deletions(-)
 create mode 100644 rust/kernel/sync/wait.rs


base-commit: 41871f4ddf710339863f957bcfcab5094c234771
-- 
2.56.0

