Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B59359A6B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223387; cv=none; b=pMDJp31/AQeVmFxm4+mKApwFzRg7cBPxz1Jqn4nE/Hr2gM9DVNOrYEqdIvrU6tgiTOX2lPVplPU8dZeJySW0UKPQSBwJDD++Eu484kgUyVOQr7KWBBrBT0FaJ8H9qLIRuo9eqV4aHFPecmFaoYdIYg8Qnwsa7k6H6P3C9PVYdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223387; c=relaxed/simple;
	bh=3HxQPuVwCVCsCaZ7W5vnVIYYhXesmAcDhblnvgUmsiA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KW9cDnECdmHZWttvWK7y15s7+UFxVoFCgS3vV2ZanURvD/I6ACJfdfTpystrmyHB3t/dvlWAc5wMVGqGKBZkcxLS25E31WV0tX/PjsUMrIcR8ZxTBvXHX/u6+DAYF9Q56DBzNSXa+IY4gI17PjzlRsBUL7UNXU+OygnSTeeHhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwU+agQa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwU+agQa"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso12145895e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 23:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778223383; x=1778828183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E8Yo81HQg3mTqMyXl+c2fp/H083zC4e16FOXpi0px5A=;
        b=KwU+agQa6b/61J4gjG4hsqvvMx2tuZW/+DQl39ke2PmaBq9FWy+FGwJxiQpFeyv8vg
         SIqiTJE7bH1K9y+D4HoXJ0daZYFRZi5I93r6D5oFZ1/Bb06vKp8VFKPO/l4o35Ymu5SS
         zOGLiLNXBgXYFOuR9w5Cvrl88dtWJXDlQFAN949oOOaUNDGWsTPY1ul9YinzwFKM23PH
         uF11LE0hJ2/7ht9RUl4byjFL6pWlwwIkyllfR6kMYXaw0Z+oUlc6unSgWJqWSLdj70/m
         3OenqOJMWogEug+57vqDUW6sRdDd9Dnq7FF5V6Ty3tJMFqGTcMklbEkUrwetkfVZNYhy
         UAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223383; x=1778828183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8Yo81HQg3mTqMyXl+c2fp/H083zC4e16FOXpi0px5A=;
        b=L1KZUWR4j+3g3hGg6DglgEdrMuNIEZA+NCfGM6kb95MMiHmcG/Lk0URLfaOm+s/adf
         ElGjIsMeVfN4sZ3tO+iUX+KjJ3f6WDaayOjVm7hctHrO6CKifgb20+c0m8Juhdtk/jYc
         3tpL4qtjOiHHRzEs6QSinud1M9IHq9mPZjL8G/hymKDOgM06pDieWq92DpoRagm9VW3J
         yGiQPdLgMM2doCgZH+MnuHtOqkY1EPvFZhLnfLtqpWalNcvUjfT3y0kkN8DfXlyGBGb/
         XLXw+e4uicYpo1NOSwMVPxQ4otGJKDf/nkXEp1kx1ERLy8JV76+7cuDSSj4lYHN3Tr8N
         OpSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7Og20M1w0oKL6p70e+3uN+SSBtJjG0KUt2UGEmUKbAUiZXFWTzC8dWs2l4fdEWYvW1WImpW+Jsc9SywWU@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfNMoENnXjjg+F6etPXh/kuXLoTkXVfsv1U2jb6JPWz64PQWz
	Fal9rp1r2WNHXOAzn82UDEuC32uyIkh1MUHHjP3/X1Kiwyekup4/m+3ZhWqTLbrJy3/qtd9S277
	N4ZuSZnAdmmMRv8zsUQ==
X-Received: from wrbfc17.prod.google.com ([2002:a05:6000:2611:b0:44c:2531:86d3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4686:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48e676b6882mr20379715e9.26.1778223382836;
 Thu, 07 May 2026 23:56:22 -0700 (PDT)
Date: Fri, 08 May 2026 06:55:10 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM6I/WkC/3XMSwrCMBSF4a2UjI3khbdx5D7EQdLcpoFqSqJBK
 d27aSei4PAc+P6ZZEwBMzk2M0lYQg7xVofcNaQbzM0jDa5uIpg4MM6BPiafjEM6xXGkEhCFAQP
 aOVLJlLAPzy13vtQ9hHyP6bXVC1/fP6HCKaMctJJgwTqlTz5GP+K+i1eylor4aMHljxZV61YZ1 lveqt5+6WVZ3lmYia/nAAAA
X-Change-Id: 20260117-upgrade-poll-37ee2a7a79dd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3HxQPuVwCVCsCaZ7W5vnVIYYhXesmAcDhblnvgUmsiA=;
 b=kA0DAAoBBFi+7ljGOUYByyZiAGn9iRCgrpOTtTq2nLtj3sVLei20k8b+wFjY7qa7V5Jur5+t7
 4kCMwQAAQoAHRYhBIOSopRNZAcK8Ui9sgRYvu5YxjlGBQJp/YkQAAoJEARYvu5YxjlGKkYP/0ab
 tUDV3eLTpGZBsMKRDpRrLsRcVHg4GAuagL6143ZgpC3nN1jEVkhnv3rV4yl9Vji/I4QIzFlZlbg
 X9GVwsWKGt0ygjsnsKasyYyK6EC4l/opAsW+8aukwYCerPtEKvnHUcuggFvgvfoziE5imdmom9d
 lqYzaTGJrDJ0IqlpqZblj7ddgF4B/F2aR8W33+DIuoRE1NlJr95DI7rY1tdrnXAEvQVkolRYdxV
 nd4JH4CKl17rOaY418VMkYsmQQIxm7LdAJHKHrW6MWTwtlYZFNkkEzmwlNPH1IjtKSHvQ86xLmy
 I5AwjeFIID1z6IYHZInKAcvCsLLXg8lAIfShSRWkXMAQE1wjLDBGQKHtKp1ybO0LCyW1sdL/wH2
 ytxzl/U7ij8IobA/Z1LkuYs/nDKqHCKakp4TAkb9ZDrHvd3M34CC3yCiI5T4XgY8ON8+d+6Vxlk
 +NoQrd5ZLNqmf4WVSjIlTrDQoVsxtIJxD+74k0GiaK0C7lYA1g229W7C4xtIaTQjzZuavZGflvf
 GJw4urGnTBz4/ztjMU3V5op1tkdfmSYZ8p2WQJpcibsPlyFMVtPwRlR+lA1j6LxLJHK8BpyR5XM
 Nv6n9cR3dMm8DRb0z1p+3NwBi8UpjU8V42qn/uDviyemNuLeydOoYie7hxXhB7Dy7wPw2tmlLNg 8xRl3
X-Mailer: b4 0.14.3
Message-ID: <20260508-upgrade-poll-v3-0-0c619fe846e8@google.com>
Subject: [PATCH v3 0/2] Avoid synchronize_rcu() for every thread drop in Rust Binder
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

 drivers/android/binder/process.rs     | 51 +++++++++++++++++------
 drivers/android/binder/thread.rs      | 78 +++++++++++++++++------------------
 drivers/android/binder/transaction.rs |  4 ++
 rust/kernel/sync/poll.rs              | 73 +++++++++++++++++++++++++++++++-
 4 files changed, 154 insertions(+), 52 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260117-upgrade-poll-37ee2a7a79dd

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

