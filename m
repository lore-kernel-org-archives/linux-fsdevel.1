Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045846;
	b=cZMOyyPLYd2+vOLTpMBp9aCj+xF9z3XslZ7LIcrhVw6rT6laNpEn0LFCa1qZyUj3i1u5
	 7TeojRhrRej+qWdviPhYd4E7i5h3viciIyc6bsIxQ+5gZpGINUeEVm531g8TlUt/dqq6A
	 r/mi/fRYxcNvSPD6NPQXpxY6JdOlXnAMZVnNexbsiuixuDoez7YvkQdmlZQSrP4At8EJs
	 zzsFq0bLuESpinYf56lMxeX61rkCzHa4tp92fnQSnbeNwMhC1l90Gq3D3CKSxyT0WiHEq
	 q8iEQ8HA6aIJbwPw5sHDYjKAxehSV/t6m6A7yy//Vl8qAsaubnz0eoHxrCoc8f7LqYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZJ83fArDtMjCRRruXCzFkCxsqO0QrtSbaShN5e/aUcA=;
	b=IDi+leaFfk6rNqR1jcL1XRwtp7dBjbOnk0IDvvtcsGJPNb9Ym6Pe8qirkL6DtnZusZkz
	 FakCmxyA/Ni5jpFtKMyYzRqtqrQpBuYABqRGtt356IGa4MSGWx5m+ytfNAanGfc16LtDd
	 Lf9hST4uEn5kWCvj4KgKSsGGe60NvPE+iylvC0AdMMHIfajhmzB0rooigPF3H0y51768E
	 SVnfsJIKWia6E0O2ZTbEZpwAiIOq6fHPyJM3NLV7mDnwdYTtEmT4ik4/9QIrUr59TauHy
	 o26lbCTKifHhIzF72qylKmMoQVHLModpSyXoFTzD8EiK1biYPHqLTd9ws2Jg/k3jbdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqxQBJrk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439C606A31C;
	Wed, 18 Nov 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqxQBJrk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F6A1F000C4;
	Wed, 18 Nov 2026 23:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795045846;
	bh=ZJ83fArDtMjCRRruXCzFkCxsqO0QrtSbaShN5e/aUcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqxQBJrk6HwiYP4p34250TnOAhdH96PC1+M1RIeeNPQKbRYa6mpYDRRKvQ+DBVzhe
	 seX+RWQbJ0wFLcbSkDv/qBGANPF7a9tt6v9abBJqjo3Um0W6aCUqXeA1cTcWgSbxX+
	 9nXD7pCMCfN4TTNP9RHYmdFW9dMgyvdMgiMCh9zrYzQg/VISDKazWUkwX2NEqBSm6e
	 kYIXJEJwYRhRpmafgPte+CQ2z73lfOKDh1PWbEnXF89Wx58T/vKOmNOCFg2QAJzRuM
	 D9Y8hfLKFuITFkCAz+tGNarsaDQakVUen+mHfpuO7T/rQUJKCxCmEUvnj2onBcXUhX
	 483yNI6xXnIxg==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: boqun@kernel.org,
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
	tamird@kernel.org,
	acourbot@nvidia.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: sync: add WaitQueue infrastructure
Date: Thu, 19 Nov 2026 00:50:39 +0100
Message-ID: <20261118235039.3176436-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117001507.1611984-1-dakr@kernel.org>
References: <20261117001507.1611984-1-dakr@kernel.org>
X-Patch-Reply: applied
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 01:14:41 +0100, Danilo Krummrich wrote:
> [PATCH v3 0/5] rust: sync: add WaitQueue infrastructure

Applied, thanks!

  Branch: topic/waitqueue
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git

[1/5] rust: task: add safe schedule_timeout() wrapper
      commit: e18830073ae4

      [ Use cmp::max() instead of self.max(). - Danilo ]

[2/5] rust: sync: add WaitQueue infrastructure
      commit: 64b7d9006106

      [ Improve short item description of WaitQueue. - Danilo ]

[3/5] rust: sync: convert CondVar and PollCondVar to use WaitQueue
      commit: 4afe54ecfe50
[4/5] rust: sync: condvar: use task::schedule_timeout()
      commit: d4645430d9cc
[5/5] rust: sync: condvar: add non-exclusive freezable waiting
      commit: 4fcb2a2725ba

The patches are in the topic/waitqueue topic branch and will be merged into the
corresponding target branch soon.
