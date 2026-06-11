Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135E3BB108
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170157; cv=none; b=hzaVS7rhcKpaHqCu6IlnxXHBLtTCVDud/tcGnYrOeQTD61UlTNU5mahkfdDonDz777U/WRfTtTF8t9dH4gVnI6HmEUhO4XSFAzhkSr5a7IqxtLV14P1NhYdYk/dbra1s0i/gJQla+ummE5pm4znIM9AzKjxZqc9fU4ydnO4zKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170157; c=relaxed/simple;
	bh=NPPOkTqT1TpRzJ6qc0T4Kx4BSxKkafhtrpIepKUY9MU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FzMJex3uiIPUZ5qC1wlT6rk2bkGore9J2xRuFBWrQXluwwf/Ajn6Tb1j6+/CeXvJ3PK898XV/HbX23QljV0vzqAjXc3rZZWGKV6TgrcBlgW56LYKwnEBhzKh9QL4sH1i64KKqBxCgsbc+zrQqMc12iQKj62qpvgpLBZUoqxB3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQ5c+8Re; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQ5c+8Re"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490c56e2576so56829325e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781170155; x=1781774955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=77PJbDzH6s4AcUzRmgwa48EFlfnKEYm+oI0aQbmApw0=;
        b=mQ5c+8RecZk+r2DmLLO44a0zem5W3ABFMOeDYlxw/DRcpD+7QgDNULvgY4yKkk9MBh
         17zliVLMYrr/2XWgO8EenXgsgq7L/0c9woREOAf3kt5t2QaCNKp4gihAQ25CmKg+dFlH
         H4566xmvi7dXoNKPp/rr4KCo71rHO1RMzqQnOeyx0bl2ZTCyv7amX1lieG4I+zInoOuR
         bRrBhI4G7EKuEkRxhLlXqx6rxBmMnT1t5XptcGWVZSFrhpvyW827fsNEfnhfpdTyPCJJ
         M/uvRfdAwa9ucdjcuYLzkT4uGDDmYL3ycsNpmGWvxT2T37LHrETbgVZ0G5LU19H2+tbU
         +flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170155; x=1781774955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77PJbDzH6s4AcUzRmgwa48EFlfnKEYm+oI0aQbmApw0=;
        b=hI7mRxg9S/xyx8sF95zQKe3BZjO1vx0eIx7FWEbpBU/UMPP13/HMCKmL9dVc5Yf+rC
         xHkGVpVibPEl//E7/Lom632tyXly93msMCyCMF1UyRPhnCO2LmPna3Mkc9sm1NH95Kj2
         9O7ZD8W5IG+EyglcfcUd0/vyT+whjVUWXBESZ/H1S+TmP65mDDu7IZMum1bEzRh8Ys1E
         2TE3HVkcpxKI2qu/6h6TKOsNUemeQDPVnRjkCRNH2coys+IY7n5OgMo3SjBgaTvHmIcY
         VC0QcnE1s4xRM4iLmuspY0NICmiz8wvOtrGQoOKMEGQqkbgG2CYsqXIDM68dHaJuv9R5
         X5ag==
X-Forwarded-Encrypted: i=1; AFNElJ9fSxxjLzW4g4JjvHk0dlVOkME8N1zGTGjSaOMbcG1cvdV1RGOZMFVbgMJWWHo5d+6jlHU37rF24oMLn1mx@vger.kernel.org
X-Gm-Message-State: AOJu0YxvgEB1r9HUn6kInlC0hKlPkzB3coeQcS7z9n96myWrFwV/wtNy
	bFg9bm1n6h+fjIDZ7GQOXVO1FCVs4M06or5zflVWmhRVbrPV65/Uwg2Je11lJVhUArdtRViwPOI
	f2h9qv9QweHe8AYA5bA==
X-Received: from wrpi6.prod.google.com ([2002:adf:efc6:0:b0:44f:ef6a:cd7b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f94:b0:490:ba61:7981 with SMTP id 5b1f17b1804b1-490e561d579mr26466145e9.23.1781170154874;
 Thu, 11 Jun 2026 02:29:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:28:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANt/KmoC/3WRXW+DIBSG/4rhemx8KerV/sfSC8CjJVGxYE2Xx
 v++U5usnc1uCC/keQ95uJIE0UMidXYlERaffBgx5G8ZcUczdkB9g5kIJgrGuabnqYumATqFvqd
 SAwijja6ahiAyRWj9Zav7OmA++jSH+L21L/x2+k/RwimjXFdKaqtto6rPLoSuh3cXBnJrWsSDF
 lzuaIF0VSrDWstL1doXWj7onJU7WiLNXMGrFkpVQPlCqyda7GcrpNvcKqeVBuPEH3q9S4lwOqP
 a+W6GWJOA4v3g5zpDzZEOPrmP3x0d4TKT5y+os216gW+3fmwg0jHgCm2iafIjlYaBY3lZMSVrd HVY1x/ltU3S2wEAAA==
X-Change-Id: 20260117-upgrade-poll-37ee2a7a79dd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NPPOkTqT1TpRzJ6qc0T4Kx4BSxKkafhtrpIepKUY9MU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqKn/k0VsDI1YlwVHIuBynoWQyXjQ2MbaxToDHN
 T0DTTq2l6uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaip/5AAKCRAEWL7uWMY5
 RvCSEACTilYFKqu328tHihyQKBYf70OHom7hLXE1ukpjytRpYRKm8Nth0LItBEwfpGGPLtItOoU
 fFHqZx5tgiLt145rD0jmR4U8f2eZup1K5fcVMvHl4Oz3WB1Oau8U3+SJxza60xra5TM74owauTD
 Tmj54dTgkLFQIrZUGBAIJKjQ7lKEsCQ5+muCgxFinp8Bs+aLgBtk7v1joWuW81vtxIaGRV7AQTj
 R9iL4N4E2muAWPcUQaB+V3iQ/omWNZkKVOvVcHil2PgTLS09Y7IEtFCiPsErxjFb1zBRXgBkAJv
 d/I3FwxVDRdbcOH9ZehR4uJA+KkfxzPap5uxlMeIqCoJk9fMRWIhPVFluL3MLpURqbbw0R/Iaf3
 spB22xVG5yuX5WbulVif8nsB+nECZgVxQfYhP3l3x0uf0OzOcybOFEMCJURnFndZtHhlEPNZ8F2
 QC8cgKxq1strwoBGDsrjcG41/HpJF2f9psfIhXYNZajuRqVFL/GWI4T6qFm+TpE7Dw+snngQ7jd
 DAEyHC1Da+y8Gk28nMjg9lSstjblFeeAa4WhKoJeU38TuWzQnPE+oqHzZEv5KKqof2fx7ywwL5y
 t+up8JYBYkGW0zIRy1AYJOKB7SF06PP1ViQl/Ral8uUJ/uA/TypR4oeWSHa6LAoJXpmezYAUj/1 zrDI2BE33KqTAEQ==
X-Mailer: b4 0.14.3
Message-ID: <20260611-upgrade-poll-v5-0-497a11c06828@google.com>
Subject: [PATCH v5 0/2] Avoid synchronize_rcu() for every thread drop in Rust Binder
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
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
base-commit: da61573f783897ae5a96c8f1c71aad6242344feb
change-id: 20260117-upgrade-poll-37ee2a7a79dd
prerequisite-change-id: 20260608-binder-noderefs-spin-3a0ec0589043:v2
prerequisite-patch-id: 3a1c4f545b2281e2e91ea0af7fe6c71f5ae0c08e
prerequisite-patch-id: e1ae5f73b329080c0fcea1d2509c085e105f67c3
prerequisite-patch-id: 63f2092c6fd9dd54b7adf93be8d5670d8490f401
prerequisite-patch-id: 5811aeb4ca435a1d4d0bb347d4de9f3b2d91f814
prerequisite-patch-id: 556e45c697f9888c8446245bbcf478422991fddf
prerequisite-patch-id: f567ba2263108b12871013309ae7c482d500eeae

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

