Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC6472536
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307542; cv=none; b=T664RL1dFevqmQpT06JgI0iCrncD2merUTm8fUe2p3UfZy5h70NLcW7yeuh/AOQLyBAWCbZ0rvPIRh9k5Mt/jElzmIpOypwiFqt5JdSFpp+T1pjeQ5Qd6lCe/y3W7oPSX0wLN8jVKWwmhuRXNwPzkrQOsCax2D33MNZA2Fl90ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307542; c=relaxed/simple;
	bh=zAaCPmmkxsrorbeQQ//eyfxoX/KNWTKV3LwFC8o+viY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hR03vVFpVq8+uvjHborTXlVniNCnTfgQxre+C8Du1VIpETNii1MWvse3NHY2QNVU0fDsCAmDwhxUoDqG8L9fvsRa+/LLEWzvwHZOp5t0/h0qzN9g1d5UNigYav8GO6XZxElvVcuFL3pvzaBHWwFuN83FWWn8iCbTVdVWaUnva2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJnVQYZ4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJnVQYZ4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e6391b114so60332385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307523; x=1787912323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5XaulSlrlyp/A7KL+eI7bd+ClAs1/B/GYM+hotcK8k=;
        b=HJnVQYZ4x4k+T410o6UNajFLX7QRHHCU2ZZO9f2HSPuyDTDlK055EIOWnbb+X/+P16
         YCMSaVwTFwpLUD+Z0y1/lsKgE90udkYEKSRVb4HoWJHarH7wjFkqeOiwLAEiiXswWcms
         HCnjT8jgrxYMI98VcnRJwOaFOjsroOd7R/YizT7vq1/qFuGRWkSBxmnwFakgzXuH3dDx
         pocBjtX2QmMaowhAw7fQcb0vBSod1D/gChnn66nl7xd1W8YkB8fpMoCdKBgcRGUXir6b
         9CzOFteMHzCAu9KT5ER38ALgERtWspxbGPYu8fbJ/TsQqOgVpxeiaZ8XZ/4KPT95ZYOx
         rWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307523; x=1787912323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5XaulSlrlyp/A7KL+eI7bd+ClAs1/B/GYM+hotcK8k=;
        b=K1OkFnDN0hA8OnbOwMF2yNFU1fjbU0yyRNJWDA+nOWVE+KhwjSp48c1ZPEAeFcGAtK
         lX8hIN6GsPexYRbybmSZfjCZgKxeJusP3n7imnXV6AJLlDgTNV9lZ4tAR4VOntXh4oqn
         Mz17KH2LM2SxYBUmHgxzgqU3/6gIyQrNGBrlVEx9uwt73IF0WFlJzUTAlQM1kIoYcIec
         kkmA0OIZCgOPArff3V1YKxppTq47KVxrMD6r3MU3EXXM7xCAb9EXq4CFNjcUpTfU+Wmg
         3sABmEIjse/YGkWpLtIr0jP6f2ccOAWlsdXNwylaJS+eFXZTMQt0K07HPu2uf38Ah9r2
         e2eA==
X-Forwarded-Encrypted: i=1; AHgh+RqfQ0HYTBY4O18uiWIVGzX8WY2NiT8Xu+3TL0VOjRWlWynCSnpCDlYDLplFhrpTYY5N1ts9FGUCUO1a8Uqg@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaXDuWnpMmmW4Yb7HJey/4a8O0XbqMnUXYoPyKu2kUHpykiWQ
	B9CnFy+KyjOChTmolON1WXkTV8KRCg4IvNZ2q19HwLTXtTRZm9Dm245HwLn+EjS6Ddc=
X-Gm-Gg: AR+sD13+26Hn0y7UkRn9GNaF/rf+pqF79Ol6jc0Lmvm4Q4E48Y+C6EVegZQRrputXhS
	H8a+bUrWZXOc5M/JeFRB09vjB6BwBhde2P9FFzDeaTB6ffDlmgKynWrD6Z85u3TP+oaET58FRtT
	52CaR8K+63tw+trylCVwod4cPe/cPl7gaIQjMwPxRsZ2hKRN3u57hdzlX7UYAe48MXewncT8jbs
	j/8hBZF1A5tDUC0J/MCmR6wGH4pRGEsw5LXBfI94U9Sh8G2C7SwcOIi2VvxCXtKSk0p7LJ/fgEX
	JaNZlyNU5kYMdW008C3ESFN9CmwRZAAo4jaT+KYI6UdgQLEFDcqDrtnd3zt/wJDTlzn1ecJWxfl
	OutL/UJfQoiI7qUCKLMl5eFfd7IHuf7IkB7l1tA12GytAE2my5YIV05aK701aMzzjrtbiekvOqm
	JmBIiVCq8xUwCX+2o5GsKzz8DGTDeZxLVTUuYLqSufvDq1/YiVkL/XkQXvWy+i8jnA011MKtUC1
	EKL
X-Received: by 2002:a05:620a:2556:b0:936:901b:2187 with SMTP id af79cd13be357-9373945cd97mr446839585a.12.1787307523397;
        Fri, 21 Aug 2026 03:18:43 -0700 (PDT)
Received: from Slackware.localdomain ([158.173.25.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937204b5dd8sm564870885a.18.2026.08.21.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:18:42 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fs: Kconfig: Alignment of code and text in the FS_DAX help section for better readability
Date: Fri, 21 Aug 2026 15:44:02 +0530
Message-ID: <20260821101824.23203-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I thought eliminating the line break and add an empty line would improve the readability.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index e05917adcd60..c341d364d53f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -71,11 +71,10 @@ config FS_DAX
 	  struct pages.  For the nfit based NVDIMMs this can be enabled
 	  using the ndctl utility:

-		# ndctl create-namespace --force --reconfig=namespace0.0 \
-			--mode=fsdax --map=mem
+	# ndctl create-namespace --force --reconfig=namespace0.0 --mode=fsdax --map=mem
+
+	  See the 'create-namespace' man page for details on the overhead of --map=mem:

-	  See the 'create-namespace' man page for details on the overhead of
-	  --map=mem:
 	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace

 	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
--
2.55.0

