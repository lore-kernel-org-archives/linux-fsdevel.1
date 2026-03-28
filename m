Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF234343D66
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712309; cv=none; b=TiI1EBb0/xv2vtgKbT41UJ/i7iXOWhHZubBG35XTYKJYf2CcwK72TQ99ySOo2P6Beraef5yHNEv++sjfGDtMI+v4dHcVEeXiwufNb/tOcaEM/H3Cr4rRZYbCk63l+utRmcXUqyvnpsH0oJqLLlestNLzSBaloTEwBwxngB+Vew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712309; c=relaxed/simple;
	bh=HZYHztId16pgGQ1AA2UfRM6DJRt8s7EcWewCjcgDwxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed1zR8ubNe4HO859P48W2lcRGVaZQ5w6grJuC9nHM8a4vjOppY5O9eaf7+CXaTp6sfd6z/hXqCQOM//FQQqHJw1SxdRud0/A96eXnZijDYg0/FK3gBXvpDKveJjP0p111edMKW6xf/rRngIo4M5QJMkeM4DCMyzNEPCnzXC0RSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGjGQAHZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGjGQAHZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so36651815e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712304; x=1775317104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqq43BIgVMA1uE3zJr5f2QtdxqeDEFGIZU0biEFlpEg=;
        b=jGjGQAHZCQpqf21JRvQ0p72RUWwEpjXDoKJqUIlIDJmAv7vBiDt06uJngLZql6YIUc
         WANmoobeQkQOMuC+MwNtKLeO2RDSZPIcIKS5NsCKn6GeaF+YUes1wR0yJ/pTLVbkUXfs
         L0wEUbuS4Y4MUzkIeN/GL7dSYCTEenczaDpMLFW1DY7UmZ5oZCTLV1McyiGutFVDvAhu
         6ptPkDEe9RmtEHPSUtv+nI+dTTAqF17dv5MY5g4XrxWpW6AV32A6gQ4zC5HtDOexz7Az
         akTFscg+45/xOM7A/yOZheEH2WMSL2FpzunIYH/eYqn07QY7f1H9rhRURlYI3VzAJ8NU
         7OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712304; x=1775317104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wqq43BIgVMA1uE3zJr5f2QtdxqeDEFGIZU0biEFlpEg=;
        b=rHAVUZ9ItXT1uEeXItzsn8UpW1PpJ5SQLUVwQIqscupZBKQH/wbfH9gx+fq0FvxKlR
         MAg94uJkyp8YYrDm/jYbWPCEoysilCrHWh/5CBVH8z9slS9F5/EeMJebM40YBRwKFQGC
         8RdM8Is5aqK3DB3XNwfpi855a0+kOn5opzjwhayKzN44/Vsbet2SxnYCrdcCGrc2p8ac
         NiXSBVnOWSGdQBh47fneidlkIuNbJtPt/S3sMEu36nWcX944g/ONsv6yhS2JaqW6zgwn
         8FSwSk2Q8CANNGNy00i+x7KzieE7ms1VrPIyKAYB7bF8bSz3ZET0h0Y5TbKRoM3VyQnZ
         h3qg==
X-Forwarded-Encrypted: i=1; AJvYcCVqUAP1qMbkYv/WowcX7CwFV+xXV8y4P1XLhUrsClfFLrmkuBPDMaRtPujyfziRzKiR1JxzbIf0lKBy7uv0@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbWkA/0s4BgihbH1yOPi3p6aG7qntwEyUsIiqkBz5q4lK+buT
	YGXCK941xAKERbuShhiAusvwfWGjT8KM3YxFxOiZpELKUzMudBk7orDS
X-Gm-Gg: ATEYQzyYNIU5SuTFW6zdH96kQscY8qIfUb7x+rR0Sif+maBa3Rb6kyixGdstutqoQuB
	Gam3wonIWUctcaJTFXxBFisWNw/9TD/AyZb9RHbzV7mVeHDNKOLwFqLXetfJEldC5Z8InEP6w0u
	YqaPu8+lo4M2/ueW5/8zPvSGX0SzXdRA9VSEcEYwxIlNHaVJhBqgeD6YAed62B6vOun9dz/0ZET
	kzS2qJMgWD7R+W036f7IBRVWZ0P72+Y52UcUZwZpXnHy4bYc4Meca4ppw/h0iUzHOrv6MP9stoe
	6Om154x7dtLGQVav0Yaaz6Cd2psVOUfzKkPZMgFo3x+eEZNU4RbTsYeAi2OkxxQ6GqGJaLhC1Yo
	+WeCCJsiuwnwLZMF6JcI+Grpyn853WZV95mVY9X0qymI/Eibuj+gLdb//StJ3F5Urx0A6Bn/Z/y
	LBQ7BfMfFP0v+MTe6/QixEml2jtBG8hZCe5EtFESLf1mrX6ahORvZ3nlgynee23uQwyvpejlScV
	fm/QaOp8DW7
X-Received: by 2002:a05:600c:c8f:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-48727d45a8emr109339485e9.5.1774712304275;
        Sat, 28 Mar 2026 08:38:24 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247102dsm7196887f8f.27.2026.03.28.08.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:38:23 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 3/5] fs: enforce locking in icount_read(), add some commentary
Date: Sat, 28 Mar 2026 16:38:05 +0100
Message-ID: <20260328153807.3368975-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153807.3368975-1-mjguzik@gmail.com>
References: <20260328153807.3368975-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0cf27085a579..07363fce4406 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,13 +2225,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+/*
+ * returns the refcount on the inode. it can change arbitrarily.
+ */
 static inline int icount_read_once(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
 }
 
+/*
+ * returns the refcount on the inode. The lock guarantees no new references
+ * are added, but references can be dropped as long as the result is > 0.
+ */
 static inline int icount_read(const struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
 	return atomic_read(&inode->i_count);
 }
 
-- 
2.48.1

