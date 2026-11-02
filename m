Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616464;
	b=qT0KY4lY6A8Ez7q5vynx5U7JD+OIRiq1JyWgwIXf/zY9agwx9cTmDlinCo1ZZwst9W4i
	 E+6l3cMi2KrfHZuXYYcwziIES+a2h2DUrphARqKaXbl2yenziTR+30/O+XBpgu2qLJcOu
	 FDBH4pr7YIRFXkrIKMOx/iqG2dQhmWMuK7n4GBEFB/92isxPb3m+kMwhJedn+D6Lf5NyR
	 F/nlDh/10Vs7AOacOhb6e08mMl4FU1dU9U+rvQPLSF4vazUyatGBBn5A/d0jMB7sFd0ST
	 va+GJFRVW6dJsJZWAzCYCPvCuBcnSUkV0Au3LNzaNX5ny1XdfxtjXmVpzse/ONLDhlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HyDSHSgspGUCXxBL33Pyf2fxt1FGBdRsUfgAbu0U2lg=;
	b=bNoDTc9OHgdrzswXLQ05nwsRtuUCLMSY184tdkHj+8VjuWWfvXcQ8+W7F5q9+j3uyMPH
	 2j9B4tuBMu1ZU/idDDzbzGIW3myxiPiZF+7WdpjjEjvpWzdq2rhixvQ9oBVrsOMxSYbYE
	 6uiNzjEeSIOL3lleSMp8XpcUiX+DkFS1UZNu0VKbBe0/1FDSirTxSV/F88KKdTdH+SKy9
	 4o6wmt0GCjA0csd0wf5u66LIewaHYTzejNSxMM0gbvmmQM43rF482qNbAIW08vYOmPgFx
	 rEaIepvQuPplGPytrVXZ1Q4cbfKjQaorLc5nPjhHmfAnwf+qBdnaQmcHonQwttwJP6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwhHSOkC;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69E60A260C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 10:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B69E60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwhHSOkC
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2729858f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 02:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616457; x=1794221257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HyDSHSgspGUCXxBL33Pyf2fxt1FGBdRsUfgAbu0U2lg=;
        b=dwhHSOkCW0EVkEHrgtbCMeCdOHGQy01fUPv5J3FY36E/daOm4zYXJc2PleAINdu8Xi
         Wdl12oOh7Ocfjrcfhv9V7UDNOWqqOcvLtO2rYrJUornb9Q5RBayX0fsvdmvvVrBU362m
         PYnxt3rRIzf5HPJo2tGlNRx0vw1VHklNdGlnkaPIjWdt90K0KoipGzXWkBr3yhVQL1XB
         XSjtERdM7KFIU182twmGoa3ORD2QAp9VipCnlapwBbsqOKbGW9Uf7qVOZtz/xf/xlkp+
         q0zJYEbqonnd5ITGqxcZfZgJIBWH/lM9ni0/Ny9gftFWtImoJgWYGAwkhg8mKQ1lVw+m
         r3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616457; x=1794221257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HyDSHSgspGUCXxBL33Pyf2fxt1FGBdRsUfgAbu0U2lg=;
        b=mlhWRL87Bp0suU/85ReXrqzFQMjBHxX2e0EFjdJPdB3ePX0qwCTpEJL7Ay8MD79xya
         5EEMyrmPvA/JRY6QF9b9K+hwE7uPzgYbZOQqxT9JGaqKNlYvr/5Aijh+8MbHqBsmn6a3
         awusB92pZjMBoAV2nDM3BWZmii6bMHM4dbz8MfvAdCZW0o2YnfIbwkAgEWqeacHXmPv0
         kr5uuvBMZQOGcXvSwb+eZ0vw+uUrJCDl5WuGZ+9V3yHAzr91juC/AOq0pDVno2VPWNXD
         rbQZKdXS2K5h6hsn5EaOOHre5WJS1KVqtqnny6o/kYnC6eGvlbmBm/wszifIUI6/AtEO
         D9Hg==
X-Forwarded-Encrypted: i=1; AKwUvBxS1kWzp7t6lZV5QPq/1xnM2Ol39UYCnzX2tZe8/iEDNCOl1d9qpX6JBLsSsXSBONRmQYca6LiBwTwWFIBm@vger.kernel.org
X-Gm-Message-State: AFq9FYJa12sMuD8dW8SDPA/vDWrMt0pUw580HzXzY248pgxtiR8Zra7L
	h0Rg1NT8ZyZKqa+iAnBbUqkFhpTPlJts51L/iYnPPxXoAnWbEOfQr4aF
X-Gm-Gg: AYBFou1mb6ZBpXX1umwm6NGfvqabIw0mFWEFqSySahIS8HSNmiapK3B/2DAdAxX51RI
	UZ71ppz+vcCMSNR4wDOIRWjqXOrBZzIluGebxoMRQL3uYu4yto9iBXKnUlaNQ6dS2KXcQrPkBOd
	/ta4rctXSGLM+bG5NWCkVQbZEiweB9yYgVgtUd3DkfzQGyQrQYzI+wxLmh40xxyv5fStIDBWdfx
	LEfCIIpEsqmjCIojzmzfaNc4LF5g4ChdGA9WaxYB2Lrx3jyKnFYYdcr2yFLxWFNa1mq9P+170cY
	lNvKGcRNz2WBD6e7t43Wm2Ztpe5aYCGEO+t/2MutaKVxVoR0QoqV3dTlmfh+noMs/Ki+CKZ7FN7
	Zn6rtHP+cRp2Oh2v3pbFpKroQMsRq5uQIqUUnEIoGzccjkz5usv5CrGWmIWyYG45FqzviZ887/w
	7LbRkKs4QDulL09ajOo7aAew/g4gyiBA5nwU3Rvn7Kk1RvRcI0n8+F3BrkQiCeXg81DRG5N3BwQ
	95JqH2Z6TiqgoB74vC7Ew+sp8vI51GvKlLZrJNueGRDCoOB+ZawlTRA9a/49Qde+mrVBOf0EOhx
	8IS7R3O+s0WjPvvHAZeCASrasFH1dh4dFjCPNEwxI1A=
X-Received: by 2002:a05:600c:848c:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4ac17d19e0amr220305825e9.18.1793616457546;
        Mon, 02 Nov 2026 02:47:37 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:36 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 2/3] docs/bpf: Document bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:54 +0200
Message-ID: <20261102104655.70901-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the VFS result, output buffer, and calling requirements.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 Documentation/bpf/fs_kfuncs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/bpf/fs_kfuncs.rst b/Documentation/bpf/fs_kfuncs.rst
index 8762c3233a3d..05cc9b657a42 100644
--- a/Documentation/bpf/fs_kfuncs.rst
+++ b/Documentation/bpf/fs_kfuncs.rst
@@ -13,9 +13,22 @@ BPF kfuncs can be used to get these data.
 
  * ``bpf_get_fsverity_digest()``
 
+ * ``bpf_path_getattr()``
+
 To avoid recursions, these kfuncs follow the following rules:
 
 1. These kfuncs are only permitted from BPF LSM function.
 2. These kfuncs should not call into other LSM hooks, i.e. security_*(). For
    example, ``bpf_get_file_xattr()`` does not use ``vfs_getxattr()``, because
    the latter calls LSM hook ``security_inode_getxattr``.
+
+File attributes
+===============
+
+``bpf_path_getattr()`` queries filesystem attributes through
+``vfs_getattr_nosec()`` and returns ``struct kstat``. Use a trusted hook
+argument, such as the path in ``lsm.s/inode_getattr`` or
+``&file->f_path`` in ``lsm.s/file_open``.
+
+.. kernel-doc:: fs/bpf_fs_kfuncs.c
+   :identifiers: bpf_path_getattr
-- 
2.56.0

