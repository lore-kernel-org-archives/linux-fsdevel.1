Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925013;
	b=ZsU/lqnQdhk3kDJTxG2qmRdejbZ1RQE5soRw+wQC0UWARMa+OyJ6fNLw9I5h6c2TWl6w
	 YUQtM5g1DAJPwTRfMVS9lMnia+yJNLapJ/5dGuyEo7PxXiVZ6sEgkwa2Bc2gJ/VbqHiWh
	 ugYSs/JGNQ5uPssjfM06qR+qqAbSqBSqr8dBAXxr+/HCAsgruBiFm3NKaVJGIQNbWWcqo
	 n0hBY9+un5qVzLuAmSRQZ0ydI9/wMvqJ4ulqP5ysfwbxcJt2iBakA2bSkzmb+i+4jnAJg
	 MmAEw758pGiiTE+7IAMmHmuRqMfPaUrxbkrKWOvjcfPR+JxHll7y/5mCDq9FTvsx0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SoUaO57cW+qqkOEye/VOIeEzhg9zr3S8sinSgtnZuIA=;
	b=lS92rTfafqzpcWB7st7uSlHhfkn3m94mCLY9tvXg3bMCCIi1OaJALQavOdQ/1ucgFvYO
	 IzGxr9Te+XqSc88ofcHFP2mz7MjfZBCxS7DquMBYVJ+a+gIF9DJe2964OCOPCliH/cKIB
	 BSK3xIO1xwI5eoawqmLO36LBZ8BElhHaUEsPJK+Oh+8bHx7m1RK73FCYip4DdaPiDCg2j
	 F4QO+KRh6KhGRjuWCPBr0Xj9JOnh4Y+22SFLjIsBXkyK5WuILiT1Qf5DqAhFUT7iFfB/I
	 JoAYt72OLvnUYJrlV0N02PRGRmh8q0j2ME0uGBVVQ3ETR/ejh9VsZQsZNIVIGRxpKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wb0t6x2z;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF46606A33D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF46606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wb0t6x2z
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb64c99bb8so25444685e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925012; x=1795529812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoUaO57cW+qqkOEye/VOIeEzhg9zr3S8sinSgtnZuIA=;
        b=Wb0t6x2z0bJUOeWrNkngiljOJZt4w2VXLN+M4uSRv1VdR88KzK8RwNj2dgBroLNDNs
         wRdKE9QBHfdk1CDuiuOVengp2OblJVPYmJ0rvO3IquYPE+w2ikGta03f8IbNg7vYJUM+
         iE1IfLcV0V9itpOfTA9MSb8yVbUSAqzSOkUbAlxwBNzNkCivTsVbjRMW24ul5mqZEmQH
         LSfn/Tpaq1v+r0R4UWhcD+NEGaXB4Hd4XrFjnT58UbRr95j83FNWCAJSCfLsqaUzrCF0
         7pnDwM2f5GGJCNbc1W2o/5xZlIV3zgMbc+N7lf9dvQpR93/+USvioFVPcMklolqu6l0g
         wL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925012; x=1795529812;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SoUaO57cW+qqkOEye/VOIeEzhg9zr3S8sinSgtnZuIA=;
        b=0E8WkMtaE4NQHwMwoyb4eNLbnUh5767p93rNBi0N6aOGB9bFIYF7zuKb5WczvFdXqg
         O/q7Il75g/Nky3LjLyfPi07LJhVmCtiWuJvDdsysbfNTIqZkkxNi00vAiUS2bXqrbtfv
         gxcoQnmd0Qc6zHuFMcP3D0R66Aumn6wY8vdXlxQkuIufTXtL0PVK6/jHAczLMHsPsZ9U
         LphixbhNUtpO5lInSHwGZym3j7zPguvP+AAL+i/TP0PNeeEV+BSLOqrDugW9MA0lWgHy
         1+JR30jxXAUY6vz+HVaLDeHeGYFYLhdcYJ2NXi5W2RZl5wJ19y++tCP0UcF3eTJ38usn
         aYVw==
X-Forwarded-Encrypted: i=1; AL+hErFhBN3YrKDLtlzNbmej74gF8B3ymx+y01oTZPbE7DLQLK1j5h8UDDsYv4Av7mjcXD/sdeVHUib0q3zXchke@vger.kernel.org
X-Gm-Message-State: APuU4Z/g44/LijjYBzZN6AofLnyiFn7F2MLavE2UxAO4ycLXF6fsVdPK
	hTNz+jsdX0KRlf85wGE4r0U/NEM37zFwG1kJT3+HsmqC6f7tVBEfUml1nSKlHsnnuU0q0KWIP85
	j1O1QXyGQJ0Nul5EPSg==
X-Received: from wmbjj17.prod.google.com ([2002:a05:600c:6a11:b0:4a3:5d5b:9ad9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:670b:b0:4bb:7987:fbbc with SMTP id 5b1f17b1804b1-4bb7987fdc3mr38878595e9.1.1794925011619;
 Tue, 17 Nov 2026 06:16:51 -0800 (PST)
Date: Tue, 17 Nov 2026 14:16:50 +0000
In-Reply-To: <20261117001507.1611984-4-dakr@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117001507.1611984-1-dakr@kernel.org> <20261117001507.1611984-4-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117141650.2992151-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 3/5] rust: sync: convert CondVar and PollCondVar to use WaitQueue
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

On Tue, Nov 17, 2026 at 01:14:44AM +0100, Danilo Krummrich wrote:
> CondVar currently wraps a raw wait_queue_head directly. Now that
> WaitQueue provides the same primitive, convert CondVar to use it
> instead. This removes duplicate init, pinning, Send/Sync, and wake-up
> code from CondVar.
> 
> Keep the wait logic in CondVar since it needs to release and reacquire a
> lock guard around the sleep, which WaitQueue's condition-based
> wait_event() methods do not handle. Use wait_once_exclusive() to perform
> a single prepare_to_wait_exclusive / finish_wait cycle with a
> caller-provided schedule function to implement the lock-aware sleep.
> 
> Adapt PollCondVar accordingly.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
