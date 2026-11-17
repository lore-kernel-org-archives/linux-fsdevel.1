Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874514;
	b=Lfubvcu+vbluRX7pEehev8Q+sglaDO48Bl09K7DGeHeXi3elz8AxpN0n78LPSqQ1xhkG
	 +RlVnfmR4uho1g205X0IhtDueXiz63Xqq3jx7aNfdNQKaW1J+eg4oyrU1ewmtvhhbSSsk
	 9rsVYWTcNiiNZjEKfflQIij+KFTxfImtBmkDa/CHfndUeYFrTGsQLj15yRaaU/04QmnXX
	 UavcUA/lmmo2PIYq7DP4Q0rP9SP+gw8kJ7vVtkLtGRRDj6C+HPTHFI+OVnb0Fqkwg918Z
	 wg2wLWbICtSkBtijrAwUeyNz4wDsO9fHv6IS/VyP5IZ/nDahYQp+08MBLuZtGkQ4V3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0D2MCe7zbqRn24q/Va+D8USPT9eZ3KVgUg8Y5omzbWg=;
	b=NiIODLwwLXqx+yLKDMragEki5/oeykFmkxSDUNaOAmeKXcukTwGE8WO6hvRDEqe6aoP2
	 gULJt3vMbJrUnRsKYITeONJooJqJPGb9b0O1VeTqZEUq45Bl3UDO9rwlTL8HKaMJ8OpXt
	 kLNEMDL24/a9PxeeSt8j2eg5IY3LKzW8kHyJfP4KoeJYCriQCJccqK+giOzp8joFaFBRC
	 wMN16aBqBofYyAGU3As4dX40NlqjbEAwt6Hm0SxuAlw9tI9yJDNnmDDvfTljhsjDHqvS6
	 qa3T7ouhOByhhc9wRUOxXSyjYkJMjPD+qjF4yVJoKIONqylK4u1vwXxv2NNNXb5Q5cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cK3LxXUs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC680606A323;
	Tue, 17 Nov 2026 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cK3LxXUs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1141F000C4;
	Tue, 17 Nov 2026 00:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874514;
	bh=0D2MCe7zbqRn24q/Va+D8USPT9eZ3KVgUg8Y5omzbWg=;
	h=From:To:Cc:Subject:Date;
	b=cK3LxXUsleJD7UBp2N4WCjKhXGxU1c8KtyZTGyxyZjYwGbrzGs/t5pdNg5zoWCeOs
	 q6ebHIddVmF479r4EWhiCJ9iEH6RBh6QslJslrci7lqvpAOQiC/r9VORnOuTuXNLeq
	 rIudgd7WjXOmwNj3L9Z6ViAEUPuiGVqNueYguE4iT5LYOLsox8tgUSz/6uu5lUplru
	 Hp24ughTcE199IUBXEDjrTjq9GOU9Q2lvIMQG+MCTOnjVdBH4Dc8UAYjqOKkaaSvge
	 HVDldEOFIPfvoVvV0oZutL0L0GCXZl2oVuSqzErbIdnNITL7wZYDoKNZ47r6FBYlJr
	 2Up/orXJdvLWA==
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
Subject: [PATCH v3 0/5] rust: sync: add WaitQueue infrastructure
Date: Tue, 17 Nov 2026 01:14:41 +0100
Message-ID: <20261117001507.1611984-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
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

This series is based on FUJITA Tomonori's CondVar timeout conversion [2].

Changes in v3:
- Use Delta<Jiffy> for timeouts and treat negative durations as zero.
- Add might_sleep() and caller tracking to the wait_event() methods.
- Gate the WaitQueue KUnit tests behind a dedicated Kconfig option.

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
[2] https://lore.kernel.org/rust-for-linux/20261104235929.1282640-1-tomo@flapping.org/

Danilo Krummrich (5):
  rust: task: add safe schedule_timeout() wrapper
  rust: sync: add WaitQueue infrastructure
  rust: sync: convert CondVar and PollCondVar to use WaitQueue
  rust: sync: condvar: use task::schedule_timeout()
  rust: sync: condvar: add non-exclusive freezable waiting

 rust/kernel/Kconfig.test    |  10 +
 rust/kernel/sync.rs         |   8 +
 rust/kernel/sync/condvar.rs | 154 +++++-----
 rust/kernel/sync/poll.rs    |  19 +-
 rust/kernel/sync/wait.rs    | 546 ++++++++++++++++++++++++++++++++++++
 rust/kernel/task.rs         |  23 ++
 6 files changed, 664 insertions(+), 96 deletions(-)
 create mode 100644 rust/kernel/sync/wait.rs


base-commit: 60fff02883397e17439c16f0e72b2f8c5f6eb791
-- 
2.56.1

