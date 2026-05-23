Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25F306D3F
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779521472; cv=none; b=nzuDSP/nw3hXmge1FDeBRKf4N9xE2ukPNoUqc98qboXnxKp9xsIBhvVCW6p/J6Rz/Kg+qeuXOEm3Ga1DovsqP+UEav2s8D+8wfou+mZ2d1F21KmtO8kjrRz3PKPaYoH+R//dJTZLn4WuDWWuxcQ5yQglbwvSfYa16lhg9bLC5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779521472; c=relaxed/simple;
	bh=YRGC1ACNPWtQq/CePTQUheUdY9lN95sX+aA/tdkp6qU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SQJ5nskchQI9/trskH3lUAnWKjx/JoOPKIt7bFfupe2LvFry1D2sYEPzxIiFBkRRYszzhE2f8wRSMYPa16SRTqkqjm2wAQi/aAKBYKpsBJa2D07iQ+p5y0i1T5js5EEuf/4U5+o1V6QdXxU3lQnRRnERU9g7ckS4oLdf8QnBirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muQy4Gn9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muQy4Gn9"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fdad6cce4so37496405e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779521469; x=1780126269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pPSPlOaIrzhcvxNDZ4LYLF/unH7lH7MrPnLgwHRHOJA=;
        b=muQy4Gn9b43UPq9JUHWyJCmQyUv72d3acQ2JiL/6JsLLgqc627SCDoUSyJqtA1fykg
         626/2QsjLFiRkQ7LsH0/t5NDadct6tqSert1DvMjYN85YE4yHmgRCR7V3mp2U6NRSdK8
         q8jWAXiajXdrqjt0M/Q/0t5mduJq6B93UWgQiI6MZDIpgzcL3Bl68zGOJToscbTiV7Vr
         jD2jYOzorgiMp7ajtSCOS+fHDKcQL2TbXPg3hCCloX6aieWBgmEyrZvyBm8Tkk32/BdN
         8v7hqt9jwabXL3V+S7YAO4c1piDNEeG/YUiX1CucaxOPeWKPNoDSW/VBQwfDx7nUEtfK
         T1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779521469; x=1780126269;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPSPlOaIrzhcvxNDZ4LYLF/unH7lH7MrPnLgwHRHOJA=;
        b=hq9SbK6BHXJgiHBuPe3wwgJmEj/zlGdt34YmNDDclME7Z+gwtXuxj3E/5ILQe52Rsg
         WvAgSbGKWKHwBTfPb4w1ENQn8A6dbI/4nYVOup+rDE2hMhlItAcb89myYPwFoB/l6VJZ
         6pypkDajtbTD8WXOpKNIRV5L9zrteLgFRqTJD0D7LHRpImO8/ulh1AA1bMpY0XymnKX0
         6uNEyWRxb4LABnibeLWOYybQx3LviVpZCV8QU7mOWEWEvbidRCMjlYBJW+ID/SyUzlU7
         7ol1QPs3G/xJGrSdCFURSPjXhSCrxGeL73RInvRRNLck6SBd8/N1rFThgClFFsaKcv+b
         MoJg==
X-Forwarded-Encrypted: i=1; AFNElJ8tlGWaX+2/X+2ORaSVMT7p+6OIx3SU2E7U8PXMGDiy/PawpNnH0PyBVleDblr0OYkbuFX/WcgwoHgXS9q3@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6wmMbmJ98wCL6qPQkulSIk+XON2GDMOyTTcvJVEx2+1lrklm
	RIPxLZEDl3q0kske+Sh7J57quw4xC4JDCZpnnvDQkJWXUDZ1fg59jOwo1fAP+cD6yKyAMyNiC27
	OCTxH70obYG2Im/8iug==
X-Received: from wmog17.prod.google.com ([2002:a05:600c:3111:b0:48e:5f11:4b90])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8686:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4904226f20bmr52794125e9.6.1779521468396;
 Sat, 23 May 2026 00:31:08 -0700 (PDT)
Date: Sat, 23 May 2026 07:30:58 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALJXEWoC/3XMTQ6CMBhF0a2Qjq3pn7R15D6Mg5Z+hSZISVGiI
 ezdwoSIcfhecu6EBkgBBnQuJpRgDEOIXR7iUKCqMV0NOLi8ESOsJJRK/OzrZBzgPrYt5hKAGWm
 kdg5l0ifw4bXmrre8mzA8Ynqv9ZEu75/QSDHBVGrBpZXWCX2pY6xbOFbxjpbSyDbNKN9plrVWw hBvqRLe/mi+6RNRO82zJlVJtQclSlBfep7nD10seNAlAQAA
X-Change-Id: 20260117-upgrade-poll-37ee2a7a79dd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=YRGC1ACNPWtQq/CePTQUheUdY9lN95sX+aA/tdkp6qU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqEVe26puT/FRKW00chJL/jq3CgrnIqVD8NfxYc
 dcj0mJI/wGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahFXtgAKCRAEWL7uWMY5
 RqNLEACEpMHNHqz3DEgDXkFWuseo0oqiw1rDbVTjzO0/wtg6HQwiMPgCFuKPcKj7NTyJBc18QG2
 +v/KE1p7DBQv/zoAMBAt7f/1sd26c8zlvwGfsaPg2T+6Q9DJnguWghRY8cBu7wdp2XV7tVoCO2W
 I5xCzFceBb3x7PKxgQxGhXd40sQH2JRPsV4YfEW2cOZ8o7pG1LX1zr1hcuhQ+SqQp4Kp0EMdXJI
 qgmhz1O4pFcmKjikIPRLULS0qE0cOVSkHYazMNfjCkhdtlpeeORHYGw33PWjKu18MfItgk2gfZ+
 FZ2FoaS/u7v39pcqr0nbBTDAnoKQ9i1YjzAAEM8laiE3vFWyyf7V3xq0oZU45PhCFmvXi32Vbfh
 ktF+awtL7i/KTc7VHIMqzZdE8TCbpt9vjHypCrwWWEfPIIPhERkmEteMOvabf68d7Gu4OzS7xcE
 8M4wQtodlflknc63ZfRg19jW0pjKllhCvfxbzoOyhxh56pozeZc/akPRWXuGbSMa2YKk1rnvpT9
 xghJ57frpqYhcjzTeDZxKwBKxVmN/pBqZyL4O5xoKe5ZDvBrQVel5xiNhrJAK1/AuYuIrwmYMTd
 P4nsv+dWwJMbN8+w60zh7b9S/75iA8mlkjZQJtGW+nzOqmwOToHxZQG4+Ca4fDb4bNSRhfxdDhn tM5w8nsXNEmP/WA==
X-Mailer: b4 0.14.3
Message-ID: <20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com>
Subject: [PATCH v4 0/2] Avoid synchronize_rcu() for every thread drop in Rust Binder
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
 drivers/android/binder/process.rs     | 74 +++++++++++++++++++++++++--------
 drivers/android/binder/thread.rs      | 78 +++++++++++++++++------------------
 drivers/android/binder/transaction.rs |  6 ++-
 rust/kernel/sync/poll.rs              | 73 +++++++++++++++++++++++++++++++-
 5 files changed, 174 insertions(+), 61 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260117-upgrade-poll-37ee2a7a79dd

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

