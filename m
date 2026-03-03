Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B13570DF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550076; cv=none; b=ZJFG6lYqut8rxUiUmuUHu2p0dkF3PEB4ufHpx+oEfhYZHDd+OoP3HYTBILsiiCKUDtuBGMRvxlyKJs1qnn+wWV9fzkgsLITzy+xGy4YYDJ3RGJZyycKmhcGaLiwm2XkFFe0bmA/hNnqwfIXNQywsRiQJhnf3FeVadABe7VcUsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550076; c=relaxed/simple;
	bh=DMyihWSrL37CMU9cx6RT6WY7U19gsgSVaKtIeKg0hZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HJQQvXyd9tXi0bTR7eOFHrankispn2cL5Xj79b7kLEs99AKa8IIKjsGU0sYirE71LygE2zGziRjmZNLgFgOrrFKE0rnM/pftU6CoeKHTDobn3q9n3LwfvmysdNiSbfjSbzFAouDpY/GI0mDOQ42nNjJT1ZvIk6cOGrYmbgFGD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCBF6yj3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCBF6yj3"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48071615686so46862495e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772550073; x=1773154873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YVHJaoIzxbdcLe9GMa6yTRmOkcHidxsv0oCyAOJNUk=;
        b=dCBF6yj322aikKLMDiAuoQg+ivOs9LVNY6HhJcRor6SbnN+z7q7O5JzCyhyzvLLeq6
         yKlZ0O1QQjD5mMS3R4qZeRcJAoHOEC+rSL2QJEmGePYEv+Wgr70WmZEm85wIQ3hck29p
         h7LYC4MfSX3c0pf/mOEJHf2QiKxIzU8Tf2cRBw3+ylXaW8qzP+o4rs7RBrygsNFcJToI
         b7OgcWWG0P3+p8s1CRctNNVvLCByqKYQwDm5C2Cy0ikYkZFDYgi9TqSdLxxUHLiaxrAh
         T1xgWeV2UTRqUqEUDpNrGTkTb9fx4Nsb0I70QQGEr+CFH6IPt8G09XZB8iW58a7o8Xgx
         QpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772550073; x=1773154873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YVHJaoIzxbdcLe9GMa6yTRmOkcHidxsv0oCyAOJNUk=;
        b=SY35pkPTx6hVKTCaZXwlhX8XljnvsqvuRD5u98Na2yUmITp7B1AAmy8WoS3dWGbdPc
         Xj22FztWVcBF0kbaBkIR3AlBmML+Xeh5dhMULL7iX3lIM971FFyYMzM6HL7o4AlTPt2q
         uDxM6ZdGsIlnUu243Jo46WNa32Hlb/qDRngq9K97P9W0zKCjtplOWHf0yZyOSwn5dBSx
         9YP1AtqhfpR6DaFWb/PpL9B9ZMwepsyKudW4w7sxxt3ax6PjvgUkfM3CHMldLjFE9ktx
         Lbo2ZWbPxUf4PyYg/lCYixCbVs90okp8MBmAJR5e53BwUuOGab9gEtn5bHqaVl8XRKLB
         NOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6obzXVdasiAFkchHGxe3/5DcG2s5x+LZUW8bFkh/HSMJRUkFk/0ftun+60AEPXSbs3Q+0oLDlNdAGaCyp@vger.kernel.org
X-Gm-Message-State: AOJu0YwriUVjr1jizoJUEc8B9Azzsgw6OIFmCF7T6flBSLKkbMQ7+Qz3
	ol9n9HlJxnLXjWPb4CbZUTBLLiyaqmbpexL/R+LSSNGIz2spCpTmg3da2wNMLOrWGNCjtJnYaEl
	3ykgtgxaZVQQT0QBweQ==
X-Received: from wmqa10.prod.google.com ([2002:a05:600c:348a:b0:483:43dc:999f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e05:b0:483:b505:9db7 with SMTP id 5b1f17b1804b1-483c9c0b940mr250340905e9.32.1772550073256;
 Tue, 03 Mar 2026 07:01:13 -0800 (PST)
Date: Tue, 3 Mar 2026 15:01:11 +0000
In-Reply-To: <20260302183741.1308767-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302183741.1308767-1-amir73il@gmail.com> <20260302183741.1308767-3-amir73il@gmail.com>
Message-ID: <aab3t00qpSBX1Gzg@google.com>
Subject: Re: [PATCH 2/2] fs: use simple_end_creating helper to consolidate
 fsnotify hooks
From: Alice Ryhl <aliceryhl@google.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 02, 2026 at 07:37:41PM +0100, Amir Goldstein wrote:
> Add simple_end_creating() helper which combines fsnotify_create/mkdir()
> hook and simple_done_creating().
> 
> Use the new helper to consolidate this pattern in several pseudo fs
> which had open coded fsnotify_create/mkdir() hooks:
> binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
> 
> For those filesystems, the paired fsnotify_delete() hook is already
> inside the library helper simple_recursive_removal().
> 
> Note that in debugfs_create_symlink(), the fsnotify hook was missing,
> so the missing hook is fixed by this change.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Alice Ryhl <aliceryhl@google.com> # binderfs + rust_binderfs

