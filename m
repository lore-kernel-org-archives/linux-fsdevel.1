Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925010;
	b=GaoLvD9ObZx5wQIiHt7cq0cpxQOw/tSghyxAOqBwacLe9mS9QqIwWlfRWAqVf/UaNB1K
	 RW1H1HXBATGgZyPo83eSMQeAgQGG5+B+Lc2VqtFS7gWj1VEmK2L0t9MKTRfPhjPlt0aFw
	 Z4L/c9iBpYZu8AEzJCtDnHMplNgK4EAjB/1LcIQFKFQUM4/nmMrbnrgo4KOMEOO3eBPDA
	 BC0PVamIOJxz4b5N8/m50bxiH29Fscd44qojOiADeGieJmjPN6njM1przMiol4Fa8xQ4S
	 Op/iYYjqDxvOcM2BBRxxP5K4LV5OdzgAY+wbdqw199Fd8P4ucAF584yKmsH0wUTvEEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nMzWFwI+mak9azVtEmWBpgG0qWEbzbvHkoZAECXYtcM=;
	b=KqBmXKP1qXTHAkqmyACkh3ZbCSXj5wIM4cfUFLEVzkXvWnrz9SLtawE3IBQBhGiV35+Z
	 2+WxzjetKuupuEOpb4Kqkseohasn7I0oAAxJ/Xkxf23e6GJF87gtnDqmCUl6/NSZhcA/f
	 m+2+yt/TtSC5vbLWVISM/h3XparyBN0gyz9PQsiY7n5CP8e+M0r3/e4bTCFFCAj+iKF3j
	 CKto4mRcf7t2TGKdza7hXae5lfkHq5T/F8y0A7Dlvufq2/F9oeYpleAUHu6zqcVmvbTlp
	 eHyd/R0bYL88X6QJnNbSzgn/INBoJrbd1cZzbi3X20qefo3W8+LSZjKysKQxsGzQk6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hLqTISRn;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DB606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 680DB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hLqTISRn
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so38855455e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925009; x=1795529809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMzWFwI+mak9azVtEmWBpgG0qWEbzbvHkoZAECXYtcM=;
        b=hLqTISRniY9yydJfP3sMzv9cKRy+pP1oJ86DI8bpQlkHnwqz71bHUa5wiz5rRHMeRH
         My4jDcmSvEGM1Kr/gRkutW6QgNpsIOK8TKajxEZHRfhxqDbglNHVBUMp7a8okF7jbWWY
         X+XqMq9NLFXM3aM4dUX9JllbHANeNKtN800teJk4u09Lyeq/YUmC1t3i/dNFPd+xOlBe
         XZ5X+fNfOczVLoq5QiNLR+/s5V1X+vVwyr6YOiARNhInnAEb0j8GX2AH1uTPtrS7IC/+
         Lw9Qvxd5steHBHpnKWQ/k6NQtCQmlqxYpEr3SZ70b+A/NCzKnIY8tNwHeE+mfEKGlW5k
         AZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925009; x=1795529809;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMzWFwI+mak9azVtEmWBpgG0qWEbzbvHkoZAECXYtcM=;
        b=cGVUtBneoZXM5bIO2Glf2E5JM8Ri4RdVWkaXneGnybaRqtN/rRBFev/uKcvc5yDPjv
         BM4XOwTWJKbzots9wf+IhoS+SiRD6MSR8zu2rhJrx6x53aKMapN5qMYIYlyz487M5gdH
         rvGt/ek3VLFGB0V7oxf9Mi6BHTc9RXMVj82fOq4PwHIjRMWcdo+Md/kwrgLwVs5UvFhO
         cptKFfPUro8h/73NAvZJYQkUJc4Ep/6iJtDtT6CoWYvs2vJLOhSzW+INcogkihNdCUys
         EZwH7NTEZoe1Ie8jzO0YQXhG1kee0KfaTJmET0GdSI9kldIfRQBuBO76wLSJXut2gpOp
         UpRA==
X-Forwarded-Encrypted: i=1; AL+hErHlZeVqFau8JnAeumcup3qFmoIG3XF94DfB6nUZp15cMJnazKxD9hrYTtUrbhBix4mdKHq1Mdw7wWt+Z5MC@vger.kernel.org
X-Gm-Message-State: APuU4Z9kN7cmRcaNYvAhecinL2OaS+PghaWKFBvH3m3wu7LnRTdUEYI9
	IAqS4hhKRol1KJdPjpCkCKoZAzVorYhlS8Tu5YibnY3avwZmMeXDtZGgkH9+9Nwgn49NQwCSC5y
	XsF+sszixe49Acm/2+w==
X-Received: from wmbjw8.prod.google.com ([2002:a05:600c:5748:b0:4bb:5e69:8177])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d91:b0:4bb:6871:8f21 with SMTP id 5b1f17b1804b1-4bb68718fa0mr190371815e9.23.1794925008479;
 Tue, 17 Nov 2026 06:16:48 -0800 (PST)
Date: Tue, 17 Nov 2026 14:16:46 +0000
In-Reply-To: <20261117001507.1611984-2-dakr@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117001507.1611984-1-dakr@kernel.org> <20261117001507.1611984-2-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117141646.2991752-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 1/5] rust: task: add safe schedule_timeout() wrapper
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

On Tue, Nov 17, 2026 at 01:14:42AM +0100, Danilo Krummrich wrote:
> Add a safe wrapper around schedule_timeout() that takes and returns
> Delta<Jiffy>, treating negative durations as zero.
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
