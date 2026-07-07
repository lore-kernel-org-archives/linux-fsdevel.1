Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC843BE17D
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421005; cv=none; b=tytLPPpyCzbaDO014d/iwxcsjGHUk/1ysO3ec0ifrJDHxriZuifILq7kxNjj9abuYoNZfuKF7lETo1QcP3lDcQThRk376yatPWIz18gjIk/5OakaGWakGTxPUDnPMFt6mJn/cPikCUOCBM6nvO2rscrfZfVW6y1keHLEU/2JwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421005; c=relaxed/simple;
	bh=2645WC39iqVWp1F+aIZ6lof+K4fnDDgaPY8BZnzy1Xk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DfWKj4aNaRvzMUnoDGibrv7/dwok2NFw1KgO2XwrDxAw4fsUxvMzh6mNlu11CbGZyLbkF5sGG3W6w6wcEvRroMj5+27U6gsNHSuu+sofcmGwwneJBEd6H85LnH3g5DrbOJoPb5SdH8NorqBK9SXlw0TfATBFg35fct7sCdCNvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORE5Jpy4; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORE5Jpy4"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bf481a6e4e6so308133266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783421002; x=1784025802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gY/mfybR7oSID2qqjoFG3uS6cVnnTWpssUKZTNDWjHs=;
        b=ORE5Jpy46V4F6xqzlJOAoEmlkoPsNE+BIQrXCIDLj8h0kEKtB0B9KpIwkYXSJHwHZc
         wURJB4/5W4TM7OHDhN58n90EX/kBCV3Nfm5YlxB4R2c8H3QGXDkEW5KQ48YuN1FOkQXo
         Y1HxtUFE0jNiitH/msHNNOYEhY/WbemTa340XBrTng0BFFKKHMaXBDBu+yud4qqLk4+0
         AtqC99Fj6f21tx9rB4QtfZVAlfna3n3ees6ksxnC7hXW0b1NBg1V6CjpemK71aeZt42q
         IVlMRXVLjY3djEs31BTFVW4rDpznZBqzB+sZg5pDnEa/24dQO98IzHDt9U2z75ZinCuP
         +DZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421002; x=1784025802;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gY/mfybR7oSID2qqjoFG3uS6cVnnTWpssUKZTNDWjHs=;
        b=U15vP+YM14fo2mOw03VkvKw3vIbfm/agFci6NHXGHs1lxXMM3dYT3tZgdSPO/I4/t7
         6vcp6wmB1M8KS9RUXW3rvyyiKLzFoOLOzEGiz5vkGU66AIPTbupdKs0cVLQaT+ulv1+b
         OiwsMcE7XCj0lDVS5oj2AoqFrc+7EMSriDL3G+/9HQCMl8Ea+6lkXu7JvWE/mxNwhAqu
         9+/IOkuviYIlbY0F98n4Ga24pXYLd7YRF0Gc5XD78ADNkKykYu95CvWPvSmUkE/CSnwU
         c1VCBGeFOnBxGCr/m7Y3csM6y3+7N1u7VWFwCBfUGzThemRvlXNVjPAdMpgelDPm0JAx
         ivHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSWG/lEhQQQZm8xWs6bDx5sIHvCmSnc7GUK229KV44+CtVH9Deo9ikDGGS1v3Qc0VMOSagX3CZmLwFqwKV@vger.kernel.org
X-Gm-Message-State: AOJu0YziGUzn4W/fL2gL1jHjJcN/Mx3UpS+Zu36iEFl08vEbqYcMoe3N
	yONquV/+9w3oIG/SRzWzliM9qZvrrmix2c1mlbuzrd9OQqqlQDkuTpoafnJ6z4ycvI7I4+6ZkAT
	R722iV3FFlp7EIdI+WQ==
X-Received: from ejft20.prod.google.com ([2002:a17:906:c54:b0:c12:6e7a:35e1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:9c90:b0:c12:5c08:279 with SMTP id a640c23a62f3a-c15a67dd064mr211727066b.1.1783421002256;
 Tue, 07 Jul 2026 03:43:22 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:43:11 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD/YTGoC/3XRy07DMBAF0F+pvMbIYzt+sOI/EAs/xqmlUAenj
 UBV/h23IAUSsbwjnTvSzJVMWDNO5OlwJRXnPOVyakE9HEg4ulOPNMeWCWdcMQBNL2NfXUQ6lmG
 gQiNyp522MZJGxoopf9zrXl5bPubpXOrnvX2G2/Sfohkoo6CtFNprH6V97kvpB3wM5Y3cmma+a
 g5io3nT1kjHkgcjk99pseqOmY0WTbOgwCY0UqHZaflL8+1u2XTqvAxaanSB73S3agWw0V3T0mo HEJgy/O/u5fukFd8v7THnn7suyxeSKPa8tgEAAA==
X-Change-Id: 20260117-upgrade-poll-37ee2a7a79dd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2645WC39iqVWp1F+aIZ6lof+K4fnDDgaPY8BZnzy1Xk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqTNhEkGszY+XyyHRj4QACFA6fJ332Ro9Y/u5Fk
 8R8warESEuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakzYRAAKCRAEWL7uWMY5
 RnVGD/wLtraz50p9Bzs0KX1tOTrhIDz0jplwCoG7coJoXJsP8AN0DW0qoAsRgs+UQC+ZNMONuwD
 YTV2MQ5D0W5X7iU7ex/CRo/zXuSsfX05GwPsUcOVvU4XpkK0IZf8hoWUldEJWMWeHnl9tdjfh33
 phkXSLP/863VS1KTgbGQ7bzMDu4QrcXpJvT1FJIgh+iYvkR6GD5GWAe7UxjKbhyH9mt1lX08XlL
 nSVxfZIkjxWPd4QCcvS87eBB7g5TPGT7Fuukf80/tsL1+gSzjlSlz3MAOFtAidzoZio/4DumN83
 SV6bjef/Zu20x7BLHTG+RFvKKckSDgVp8EF8vnAdwldlZgbxvvdlCnyf/h5TW2N8IaUvb7J8f0T
 5ZcdhqpbZxerzn+kGZ/5j77/RqyyqbwGIAF5EinEf4BR6AED3ZVMn3fWJdgbaWemdugJQM0XlVk
 iGY6g85swsiYOeh7uPj2VrPT9szgUyC/fk5f0+RvrmVp/alhTHXeJe9Q3USa4gNeP23F4YNFS4T
 YHKUtxOaY4KGn8rnb68LKbAiVB3IavA0+nb1MZnNEPFHxvOnRw1ZHRDIwT3SDiN3+UXoA+2dgbc
 Gkb17i07uuckjaOdMx0u+rU5A1vQeZfbnKJ8KfivcCiM4Mer+I1VUb7TRabDNdFJbfo4EeUdVBU PfNqSaMOb7k67TA==
X-Mailer: b4 0.14.3
Message-ID: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
Subject: [PATCH v6 0/2] Avoid synchronize_rcu() for every thread drop in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Right now Rust Binder calls synchronize_rcu() more often than is
necessary. Most processes do not use epoll at all, so they don't require
rcu here. Back in Kangrejos I came up with a way to avoid this. Idea is
to move the value that needs rcu to a separate allocation that's easy to
kfree_rcu(). We pay the allocation only when the proc uses epoll using
an "upgrade" strategy - most processes don't.

Based on top of:
https://lore.kernel.org/rust-for-linux/20260707-binder-noderefs-spin-v4-0-7c3c8bc16339@google.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v6:
- Rebase on v7.2-rc2 and node_ref spinlock change.
- Fix conflict with commit 77bfebf11077 ("rust_binder: fix BINDER_GET_EXTENDED_ERROR")
- Link to v5: https://lore.kernel.org/r/20260611-upgrade-poll-v5-0-497a11c06828@google.com

Changes in v5:
- Rebase on top of series converting node_refs to spinlock.
- Reword comment claiming node_refs is a mutex.
- Link to v4: https://lore.kernel.org/r/20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com

Changes in v4:
- Use SetOnce for PollCondVar variable instead of storing inside
  spinlock. This avoids calling poll_wait() under the spinlock.
- Link to v3: https://lore.kernel.org/r/20260508-upgrade-poll-v3-0-0c619fe846e8@google.com

Changes in v3:
- This series was almost entirely rewritten to use a different
  implementation strategy. By moving the PollCondVar to the process we
  can avoid the upgrade logic entirely.
- Link to v2: https://lore.kernel.org/r/20260213-upgrade-poll-v2-0-984a0fb184fb@google.com

Changes in v2:
- Change how Rust Binder handles the lock class key.
- Rebase.
- Link to v1: https://lore.kernel.org/r/20260117-upgrade-poll-v1-0-179437b7bd49@google.com

---
Alice Ryhl (2):
      rust: poll: use kfree_rcu() for PollCondVar
      rust_binder: move (e)poll wait queue to Process

 drivers/android/binder/node.rs        |  4 +-
 drivers/android/binder/process.rs     | 67 ++++++++++++++++++++++--------
 drivers/android/binder/thread.rs      | 78 +++++++++++++++++------------------
 drivers/android/binder/transaction.rs |  6 ++-
 rust/kernel/sync/poll.rs              | 73 +++++++++++++++++++++++++++++++-
 5 files changed, 167 insertions(+), 61 deletions(-)
---
base-commit: 0e77a935cf137e791c672d21bb80441043017ff2
change-id: 20260117-upgrade-poll-37ee2a7a79dd

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

