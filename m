Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004550;
	b=S4cC6rKRHQ1zP9n541zzLgUzbircnj0JxujTZ78hS4HmQ7BRpaed8Gsr6mVob/Ka1saH
	 raSGu1Te82EQMewLALf6jfPdAKT9wOASvQI6Cppjjpoo0dH1KEYhZeiKZ20RyVaWhH2j8
	 mze25qYCLBHq6NRvrhgOOUUSVRm8gouT07X4+gH5IdD73d/mUL+eGYD7LK0rzSjTY60Vc
	 dkB9EWUWg4uIliARKnK6PKCWRrEV8NA47cH20eIgQTMEvyIQ7DmbFNW7Sw/Eng4/hM6H/
	 srKtlTFQY52gOKFYEJ+tMU6U46citr1m1dgaCOCMqnJfm/Qzqx8WvaXqpmdi97j+i0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004550;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To;
	bh=7Kqy0aZBC4aYP1/HEz0eIXtq4ha6A3YQql0CuK7cJzw=;
	b=Qx6kEGCv0fX7dE3sgHZPho/JV8YO9OIceA2B0UY3RkmAPyPISUE98y9m988de30WuN8P
	 NKR/bmKz4rsq1iQIPfvj2576y7qvvISUzFDs92YEO521nFCj6Is7nWuuRyEPyWOGKe/X/
	 1NdpUUJY+ZbGUdGAogUSwU00WQDXLA7+r3fLE/hgfHFI40VlDfLy9kzkKAehXBQ/aJBWy
	 Wcgc3JOUv8MgUbIRtmzoiKWDoRNqbUhh9lHFwvrWsTEXiQZn6n342W8pCXBrWU/LecgOJ
	 txGSuOddIsBVHPmBJBoBuNf/xNznQbR4rcl8TNvhAanOQIo7RZhODw4feQ5QcYOKT6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBdsXcp2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F41606A334;
	Wed, 18 Nov 2026 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBdsXcp2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D21F000C5;
	Wed, 18 Nov 2026 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004550;
	bh=7Kqy0aZBC4aYP1/HEz0eIXtq4ha6A3YQql0CuK7cJzw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=JBdsXcp2eDG8wVwv4b8peOTyFJjpW9moO74kncZpQxR2ihT05KcBTUEWYIbil+DXk
	 DsjBfSAR9t24WOJCg4cUfNZ7webF4L9ABnuOEyLZfMIp/3XzTeOQuMAvMHD3Z7mIVC
	 gaNTs18yuVSb69PjeK45OUidT810VWed45Ejx5cylPtgOWGny702kfaoREA4KMY6ge
	 MwOF/XNbi0gAkkq+ybHCl9SCydmO129bg1NabtElSXukihGhV/N3FmFBnh8FsIdyD6
	 I87BV4gP/R5UuF0qxghvl0OVDsJzSlDQgi/XB/vRjrjUwvoreZeF6d0L1Z10a6hdR/
	 WxTQEG05FmZZg==
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 13:22:24 +0100
Message-Id: <DMYC07XW5HN0.2N8G5STNNZ8GR@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/5] rust: sync: add WaitQueue infrastructure
Cc: <boqun@kernel.org>, <aliceryhl@google.com>, <lyude@redhat.com>,
 <daniel.almeida@collabora.com>, <work@onurozkan.dev>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-3-dakr@kernel.org>
 <DMXGWCITETPM.1OCWS0ISXH5RP@garyguo.net>
In-Reply-To: <DMXGWCITETPM.1OCWS0ISXH5RP@garyguo.net>

On Tue Nov 17, 2026 at 12:59 PM CET, Gary Guo wrote:
> The first paragraph is rendered as rustdoc short item description so plea=
se
> have something more descriptive and leave the C equivalence to other prag=
raphs.

diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
--- a/rust/kernel/sync/wait.rs
+++ b/rust/kernel/sync/wait.rs
@@ -35,6 +35,8 @@
 pub use new_waitqueue;

+/// A wait queue for sleeping until a condition becomes true.
+///
 /// Exposes the kernel's [`struct wait_queue_head`] as a Rust wait queue.
 ///
 /// A `WaitQueue` allows a thread to sleep until a caller-supplied conditi=
on becomes true,
