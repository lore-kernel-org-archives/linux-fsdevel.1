Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CE3BCD34;
	Sun, 26 Jul 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785105384; cv=none; b=De9kwVkSSRph/z37fQT37sel2h62nItQzqU6KnFayKCteKUSPV+roGbCgOexw325tZcKsy9trt8hY47A0gnzKw7a8TQYlUYXjbWU6Kbt8m+dIRoCzUAbrKivQ57riNSA9EdBxu7Pe2qdZPYfWYPMtuOUwGBt7UVNtIrI5HLcxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785105384; c=relaxed/simple;
	bh=0ALCbkGr3kGr1fHmhYGJuj6v1+EingvT9DQ2AmbDGNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gE7UyDd57LZtc3KLKDZttVUu75GBAVkBnsLwT+1euvyMVp/SqqP6CqGBlAAEm9L2UqVmUZ9kYXZkqkS1STNri2mUWkuok8M0EVc6i2kyyf3NStzqTNOVlSEFQyOKPtsz8SVrvCa+0vTpk4ts8tjWENBKfJXq9I+ZPPfQyXA1ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo92l6TG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo92l6TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E421B1F000E9;
	Sun, 26 Jul 2026 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785105382;
	bh=8dgquFD3951LYM8Atd006F+Nn8DhxEOEH+D28iA6SBE=;
	h=From:To:Cc:Subject:Date;
	b=Wo92l6TGl7j0JSCCS/7rCFYVPf3Mv18ThbIQ029sioVw2nBO85XcOob3utFgAv7Oi
	 WHWi67xd7VT4SnhQfZhNwoNgfMDXZScH6rO6HvWwDj7jWuGa5xZdAybj5fIlD55R2l
	 CA4hxaqo9nz5BxiKgYQHb4RXrsMktSxXffKoXuxwOkwMiz+/EpUtyHRCw1o24ZcJG1
	 HtTwwc/OUSzV0PkSi/80tKeMl1hpjSyAt9BpO1GBnIPNiT9fwx0Tws+iEERjEKGqbS
	 jn8oBmpTo7ovG5ZzS8LnNQftAHgtTXsMluWF/qw1GgFDkjc+dyf4BhUOKtYicDpb0R
	 W31+SxMfH0Y/g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com,
	boqun@kernel.org,
	gary@garyguo.net,
	lyude@redhat.com,
	daniel.almeida@collabora.com,
	work@onurozkan.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	tamird@kernel.org,
	acourbot@nvidia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tj@kernel.org,
	jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/5] rust: sync: add WaitQueue infrastructure
Date: Mon, 27 Jul 2026 00:36:06 +0200
Message-ID: <20260726223613.1242940-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a WaitQueue abstraction wrapping struct wait_queue_head, providing
wait_event()-style methods that take a condition closure directly.

This is needed for a (subsequent) DRM patch series to wait for in-flight file
close operations during driver unbind. The Tyr driver also needs it for "CSF
firmware responses and other GPU-driven events" [1].

Convert CondVar (and PollCondVar) to use WaitQueue internally, removing
duplicate code using WaitQueue as the base primitive.

Also replace the deprecated system_wq wrapper with system_percpu_wq and
system_dfl_wq to avoid introducing more callers generating warnings that would
need to be converted later.

[1] https://lore.kernel.org/dri-devel/20260721151423.444175-2-laura.nao@collabora.com/

Danilo Krummrich (5):
  rust: task: add safe schedule_timeout() wrapper
  rust: workqueue: replace deprecated system_wq with
    system_{percpu,dfl}_wq
  rust: sync: add WaitQueue infrastructure
  rust: sync: convert CondVar and PollCondVar to use WaitQueue
  rust: sync: condvar: use task::schedule_timeout()

 drivers/android/binder/process.rs |   4 +-
 rust/kernel/sync.rs               |   6 +
 rust/kernel/sync/completion.rs    |   2 +-
 rust/kernel/sync/condvar.rs       | 104 +++-----
 rust/kernel/sync/lock/spinlock.rs |   2 +-
 rust/kernel/sync/poll.rs          |  14 +-
 rust/kernel/sync/wait.rs          | 385 ++++++++++++++++++++++++++++++
 rust/kernel/task.rs               |  13 +
 rust/kernel/workqueue.rs          |  40 ++--
 9 files changed, 469 insertions(+), 101 deletions(-)
 create mode 100644 rust/kernel/sync/wait.rs


base-commit: 6f6629ab2185d27cbc65d7d85908159b1293c082
-- 
2.55.0

