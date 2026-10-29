Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270358;
	b=0MJwXJ9tUjHClEgMYe0WRaXv2lMbNMx7fYYHi9z5EE4egdd1ZznUd+UyNsHgfG43giQ7
	 QtcnEgdtwZFu+9947s8VYK9DEI3JFpO9Nn51XduC6knWokcCmo/fbyLLyxv8xXKxiLG+f
	 kzHUd/sInc5RfAL9fl6qd7jrQJNkVab3XdxLn0k72xIA8BQEGSFlp83dm8iLEv1uNimao
	 bMmv/oF+ZViXaEMud6eoR5iiY1GyAJwRU7KK6wM9i76qPQm5MUdQ5+QdlEtJ8K24G19db
	 /2fQqMHvMfY3Kq6OlHG9qu8DyRYYMOmumn8irfi/oVk5ZkT6jDInb7Bru/I2hmoht4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8eGXEP28tBZsuowcYGbYE9SLL2m94ii1a9Wvq9NDd3I=;
	b=WKe3OkAj8OokaSe9y4M3UyZYP3v9M3VBDq43Nn9hGZEsW3mnLSlgcb1mwzgKlZieqxnJ
	 iFHKCwOpHFCIuv0/UK1gCPO0Igffln44aGREuY3hlzti14YXQqxlFdBCZdXIN35OVSYtk
	 0ImaWgozKrn4ony4Mp147WJg3x2z0cI+kyjTh7i/vC6kaXo50sKqB/OECVw1P0RqW3IiF
	 hW5eOTdp3smQ5mpje0F1x67ezu6VrH24zNShHwCe8HOhvA5jM20LRVpnV8To93WbYvm57
	 6JOrF0Ig53LbB0nm9mJ3i05R4XNuL+wcGKW5+99xD8ZojIWGLE+PIst7K8zbZgQqMgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qurrekCU;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43254606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43254606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qurrekCU
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c46d41f6af3so290986866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270357; x=1793875157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eGXEP28tBZsuowcYGbYE9SLL2m94ii1a9Wvq9NDd3I=;
        b=qurrekCU6tTX6qsWPGalnXvKxeHMwE3Uml/W2Bj+8qWdC49HwCv/BidCIm+xyr992d
         vopDsO/aci55ZL0mJhc1m05Ul7SFK6OnTnp773aBGRstm1AJXYkcc3BnJkyRQC6vh9gD
         NLzZ510CoYbmFraiCKmolkqZQetWGsDckN21C0P7N91/vK6gBsy3NaPGMJsNvdH8hYqx
         CmTCAgaFOBNaaCNRH4XHoX9NujuiZfzTJFPsXoem+yBuFhO2jCDxvkU39ihoPp5m4fJC
         U8aNwe7hYQEKquOpUErq/vJo7IwBFMenEmgw2fUHEb+VYBwai/TY3IkyeoyKeKTAan9s
         EwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270357; x=1793875157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8eGXEP28tBZsuowcYGbYE9SLL2m94ii1a9Wvq9NDd3I=;
        b=kwHa4P43FCFJ22VBp0zXIYWxlnHiwzLrtR44OZtEmbpjkmfubF0PXZpTha3BMDHNvZ
         9mDr/Rtts/6UQGB3HlmECNibHV87yG8AQAWvoBhAf/s+lvwpXFmhDlODYO671SeEzoIX
         x6sgefvaCyXKu4BcloZY81Prpfiy4E+MP4zI/kg0csNZuLGioZuTmjnV2AMRkA6G15Lr
         6B6RPeSFiHWJtIkR+6oklDAYkmhljZoQbNKQmksYauUVV4/ffVqqXa5iQpAmowrKAUaI
         /HbI6Mih0+Mcje+UuN2hkWq4HALm9LUgsOcx84Go1AwUn+B+o4F1f3Eo7NJ3+2hupEbb
         6lQg==
X-Gm-Message-State: AFq9FYIaye+Pt5sGkrcUOOCVckgO99vWLDGedr519jp3bDd5Jhs97ARf
	vlLd5TyFgj0TfFdORfWRdRutmIuUV0w1Xkr9Oo8+2I7wAeuVG43q3c4w
X-Gm-Gg: AYBFou30wSFLJi6b9PmTGcKu6PHyxMcN9tv7/6l5xw5wp3RUii9x5FOZVHnxA2Dq6FW
	mikMuDcD69wir5Oo7nIP1j+7lqHdfKzkgkUuS+SySk+0dD/azdUKu6n+POQ90hKgoydJauFJeNU
	1kjismSKunqHey59AW0cGnYQUlYIj3u3lojwqaeuGFFsfNSOxn8VcjrGtA7qFUIWbZCEsqlZMFY
	zAHyp9+X+e5FmXn8J8ae8jnyyc/9R2xhuMPDCEaVxghIz7ZA5eo2Q+cD8Mdaw/jECdmljNOfClF
	v2zPCOqEwcKxlNlLmvfajoq9KaC81FtIr+o91to8UriJDgfaVH5DVO3sH3xMZaAxigctAcvTqNW
	AFs0PNj8tSMsYzZdrhB6BOmRt17jeIZ6s4ctc2YFKp6ckjtokL7hZnrr7E88i2Fsj7oiclx27jd
	V46SIzh1dYBwAmatSbQsVqrZUiJAFJMy6HTxjY1yP1A9IMPrBoywiZ34MapOhL/lFf71l2nsUJz
	Ig6uCVA/mI2AjM0Uz2nBlVM1sQZoljeseB7q8qb9Xwazbc1JsRuv4OQShWA7sk0f9t4ewTgyJJ4
	j2DCQ+RH436KbGMBNpR5il/zL/X+P267jQSOV1F4rXTC1JdcVk3zZ077O1gbRmlA8wF4EDyMSNy
	3RtzAaFeKUds=
X-Received: by 2002:a17:907:1b1d:b0:c42:a326:78a9 with SMTP id a640c23a62f3a-c49be054ad6mr449212166b.42.1793270356461;
        Thu, 29 Oct 2026 03:39:16 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a4e2401bsm400326566b.84.2026.10.29.03.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	Fahad Alharbi <fahad@codepure.com>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 01/16] ovl: do not copy up an xattr value that was never read
Date: Thu, 29 Oct 2026 11:39:05 +0100
Message-ID: <20261029103913.2785828-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

Copy-up stores uninitialized kernel memory in an xattr of the upper
file, where the user can read it.

ovl_copy_xattr() may only pass bytes to ovl_do_setxattr() that
ovl_do_getxattr() has read. When the read fails with -ERANGE the
function asks for the size again, and if the new size fits the buffer
it stores the buffer although nothing was read into it. The buffer
comes from kvmalloc(), or it still holds the value of the previous
xattr.

A FUSE lower layer that answers every sized GETXATTR with -ERANGE made
copy-up store 4096 bytes that the server never sent, with a kernel
pointer in them, as an xattr of the upper file.

Fix this by failing the copy-up with -EIO when the size that follows
-ERANGE fits the buffer.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e963701b4c877..c220cb5d0b70c 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -131,8 +131,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE)
+		if (size == -ERANGE) {
 			size = ovl_do_getxattr(oldpath, name, NULL, 0);
+			/* Nothing was read into value, so it must not be used */
+			if (size >= 0 && size <= value_size)
+				size = -EIO;
+		}
 
 		if (size < 0) {
 			error = size;
-- 
2.55.0

