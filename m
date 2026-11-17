Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925018;
	b=AlTDYx5GkLL9nSY+y3NKP6/RSbW3t0THZ6J9Kbz24EqzZSlApnWIn03a1NYVikTdFDjS
	 xlWNZ9pI7oajL1cCPITG0RsZPnrW/OOWdNHxquEdxFGm608VRpZgeukAvHqelWs+uhPOn
	 /2HCH1jEWcDJhINmmarnKeM1+CNGZz7OVmYWT0m/VVnHMqB8HauDWl0oe6TeGg5lg5oSQ
	 axlZTuNIG1881DmEEC1zmXcjCEIKi2iSL3DP4AYgs4DQrQEBOcQik3wBmx+xmVo0Wuh6A
	 YqRXzk7q3Oim/J1/+9u0pNIBjj4IbGqbK8DOSBLFUYE20ehii2heRzu7oGEUUKW5ZjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nIl3+ZTBmWuTNVlAHNadUfeBQic6MCWYrW6NjuO/0k0=;
	b=1Rv1XClQv4s9s9NBHrye18ewYQMDwoVec3vECBXgjFi/kys3Qj647FTpA4EyKb/YzqE4
	 HP+NAnDCYUjwYForexFQCB8YQRLcKpt2sm1iSCou6Jmrt2nJ8Ck1HpBQgjnz98Y06Fy29
	 BcmFb3DdIV8pVPDVmgpzdFcPyBuytIkQO6KqbdAvlbIyA6dd6pxPUy9i0au6ZQUbKQ3bA
	 zfufbOqtXQxueq0BMUDOoIlmhDSLTIub//bc904f7OoM57Hq5dKOrn9x9O56njkSyW75z
	 y+19XBLrnuUPZYmAhGf/MBTi07+0XzkGy6nXHnQqorxbJEfzztszpugHnGiNRhHYT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QeX/dnxq";
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9F606A88E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE9F606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QeX/dnxq
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4901562b819so4459160f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925016; x=1795529816; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIl3+ZTBmWuTNVlAHNadUfeBQic6MCWYrW6NjuO/0k0=;
        b=QeX/dnxqEc6d43KFqTdsCS1WhoLlgezZSBEfKcG2LIQsVC68cUqt2AHn+gKi25tHvq
         mOhVO1IrX/jefeUYw2/kFd66WyaT/G3vltXAxnI+LQhvVoudPj7LZi4Fh/M0C/uvZv8v
         X23lcpxNncAR4NOsHHBF/C6aPdma1ynpuItVNU4ArcHXGI0QDxggiM+wxlauKNgtJDi+
         V0PXTJBdqGMjHAqlEPDF6TTXRy8RvKzJM3Wew9OYeH15hjtg/ry1vMbj/EyGVDVZhO3g
         LEkMt0gBF7nyEvP4+oEyuG3N85lASqpCdMWA7gIRWx2MifesyErezf1n4jbr5Ze3V0zT
         5pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925016; x=1795529816;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIl3+ZTBmWuTNVlAHNadUfeBQic6MCWYrW6NjuO/0k0=;
        b=QFwnC5b7XuFP0Auwph2Ur7iW3q7dRQ+SXSOR7tPn7+wrUXz+WmG/GghxzrFNWqnlLr
         yLeZFl/kWoW8+Ji8lf8Xa2Difg1y8qq73oA6wF0U45jgRFMW63KEdhl2y7vv4/ah11BO
         H/mlmkgyKZuSR93HFIQWiKJGJslsTneewQEnm0hhdDMB/CUXylc6OU8fIUQhb8gVLrm2
         eR/zXsBLwFcWuekI3aXVcuM1nCrnVBDLRGlOxlqLaFFqJfnn4zdUF99hysZtNzRdsNkG
         kZcOSxLcsp3qv7zO8iJZ3JjFtIi4iWpqaaS5Sk/nh0UkLSwTaVZrE1kWMn0XK8nlCZst
         yf6w==
X-Forwarded-Encrypted: i=1; AL+hErECEn0wpE1MfRpy7EiEWdQYCtkuCtYhL74RgFEHviE0evp4yXqevU/cZ5bgatVfiqd9J+x/d1Yld9O72CsO@vger.kernel.org
X-Gm-Message-State: APuU4Z+yGyZvktGkMGtLHPEy0WCglj1gmWAM1W/okZja+CQEJi9O1qMI
	rsa/jjMXSONqVER0AFRhOBPAmzHgpdlwxXMQ6jbd1oNxE580aRL+FCklkA/3MGAh4plnzvdFPiM
	n6B3i0UXSSlcIkBZEyA==
X-Received: from wrub10.prod.google.com ([2002:a5d:4d8a:0:b0:493:d140:f479])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1445:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-49c72306b93mr33480234f8f.57.1794925015465;
 Tue, 17 Nov 2026 06:16:55 -0800 (PST)
Date: Tue, 17 Nov 2026 14:16:54 +0000
In-Reply-To: <20261117001507.1611984-6-dakr@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117001507.1611984-1-dakr@kernel.org> <20261117001507.1611984-6-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117141654.2992573-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 5/5] rust: sync: condvar: add non-exclusive freezable waiting
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, boqun@kernel.org, gary@garyguo.net, 
	lyude@redhat.com, daniel.almeida@collabora.com, work@onurozkan.dev, 
	ojeda@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, 
	acourbot@nvidia.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 01:14:46AM +0100, Danilo Krummrich wrote:
> CondVar currently registers all sleeping tasks as exclusive waiters.
> Add wait_interruptible_freezable_nonexclusive() for callers that need
> non-exclusive waits, using WaitQueue::wait_once().
> 
> Document that notify_one() and notify_sync() also wake all non-exclusive
> waiters.
> 
> This provides non-exclusive waiting support for a subsequent Binder
> conversion.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
