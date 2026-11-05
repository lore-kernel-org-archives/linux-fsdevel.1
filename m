Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892781;
	b=kkAKO9Fn2D9JsMnObBnJIpDCXhB0zD48ywy/Q9zPui88hHg/GPWEPO9dZdtMUyuaLRPa
	 XBm4jlWnQ+fUvA/QZs0o9nPD576XN89tFBEM4m6x5ieXRYfqy873zLEXCDxB99SPWxzaT
	 do7nCiFsJQQX88yaQma5tLJ8HuMRehpnSTXU4uA3OPTSqtG7o6+Q8HEK3BNdMOt8bNRv3
	 /2eGoBiFaKcJrjhYjxW4YkYrWGYH99MFnN7P8eV86fxRJVRTL6hklAI7C9WNnDV8Ebggx
	 1El7hJe0+8FOn7paZ/uOLY6IRwOiS0TkvCZHUhDeVG+dEXjXgnDiXr/fH/ijHUtVh5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=uuK+rC+pImDa1yKVfuZPUdIKUxMs888mCbmWCUYCr2E=;
	b=LnNV9j0dRKs/KmqQt11jvuT0OPFn0FZKPp4R/cq+3luaGH0J5W8mTq2MP7szH0sb7CIO
	 /UY88lVIORPviZRNx/biCyG2AW8Ehin8SBP5rcwXkqm+GE1WaX5m1zkt5hc+Bok1nlYXd
	 p6QbDpgVGsmy6hf77IHvzv/PkNrq1W8vUCnBH5eszzPnQNaKeaQv3cvU8JzsYMIX4oz1g
	 mreiRblDoyg3XKkASomcDgPkQ45fuRrQNk8vYlUv7ZEDxL/i7l6fuAsVYEUqWNCgvb7Fc
	 FYKQjsVVMU7dDO9ZzGpJ7UFQyWz5EYCb9R9/rFPU5AHhgQhbhaOqnX+GLPePWNyjUww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cQPvhp7m;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA7606EEA1
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95CA7606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cQPvhp7m
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93ece7a73b9so228540485a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892779; x=1794497579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuK+rC+pImDa1yKVfuZPUdIKUxMs888mCbmWCUYCr2E=;
        b=cQPvhp7m8BX+lPfKLlWHCQ91glFCJotQdDSPuAKrDP1k6PSvzB7KcdbfsJbu9SwkKL
         JP8ha48FLZ5ddf4+Wc36+U7H9xAH8Ah1A0E4mrP+V6xWskCJjWey3qM7j0n7CVSlsI/T
         oK/7bXWoNmgN2VbC7Bd8FpKBNiqUFtA7ydN82CaUXZ3AafMrPaKmzpsSLL4oL2p8yYKK
         2zQCGRdLg1/t9ZeVUGuUzRSvdVwVaruzHJ5dtwR6nOaRcSCCsU3qFmB223boHyuSc3Sr
         2BesPaaJf9D3LyZGt7IjCOM0xSgZrr/mcy36+UIEzx82mhe1QVEFdxirx3Zt6yoDBWBm
         ykWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892779; x=1794497579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuK+rC+pImDa1yKVfuZPUdIKUxMs888mCbmWCUYCr2E=;
        b=pHIiKTu4ifqYi2huSoDHew8ZANS3xxvq42m2gXVM40QKQoL92vsQTgD24CgXKWp42B
         C6sLGfcwkvec521K39FKM/Oszuvpxr7JH7aKTFoFqeI2tcetz2xWTH90M4WdgH5eZmhb
         c4CLCTmVzAHZAKMWsUWyMdlNlL79IaK1DQFJ74a+NaS8V9rvFJkHL2ybQusw79BbgYOy
         G4+Kn3iJfc3DhCOk7kTTD9tB5JOMzMamisS8QIgeEEMKEHsYnpiTKV/gbPjUWTIDRqls
         aXsjF4XwktRsXbCea2W36ZbzIwzRBTmYK9r5zlOcYJ3/eUc2I7rHQFJifn1YZREKeafv
         BfkA==
X-Gm-Message-State: APuU4Z8qfhmWPR3GOzGEfivqPZkYCgts4kcqQg119rX+7afyjYsTURHh
	jfITdLGmjPkhxGtkX2ALcvJx/UP7wCuAcYYalLVQurM0jelpz5e8ne6jOEu4auwO1sY=
X-Gm-Gg: AYBFou38cqGdcyxQqdXrL0Kz6qg0lELhkkoAWbJo2sp7E6Y8OPwzrVe5PWfg+Zf6VIp
	JVbY2zGSB7gNOQb6GJwvqkOObX1xt1dDtJGeHdBlj8olC1X9VdK2Wc+hsR+0qwlsz7yTZczlTqn
	R7pVenh6REjEKwcrQh0OrvAnYxYl5o1dQ8nvv7zM2zS5xfXTDyJvlXGFYcIJSmPC2eLSb2CG7tK
	aYyVJpaixKvgP2clBddXoEgFXrgJTSZsZc/f0ub46yH0c0N7JyHtcPUZRvlS7FlzrZUxFiu9DBi
	+ipV5wATRXVOZLYU/MjqLFS3huZ1Ql4IilMWtEu2Du/BVB5VsltgFS5DSskhYS7dwIxE/YruGeq
	aPQl8M7j8SL9M/1Bm891S55zB2r4INIx9hwK4pYu1HezK9t5ZaspSVPqM3UNy9McuHu1iaG4iMB
	+rfneIxiuuhm3pBSN373RBG5y8P+0/hX8qNnbK/ndEli2Y2L8fUUno3XsnNRgkmrZ2prQ8qwtsX
	mxrp7RITCHtM/T1GTloJpY5kgklK1B81LbiawnDUmd3mVYFrrCqX4Qw6xhqs+wvl1bQKunlkZN1
	Wkpkaw5ka+WQWtUfAzIW0euFpRylRkQEBEJ3zGoNxs4LUA==
X-Received: by 2002:a05:620a:2994:b0:940:ed45:c8ea with SMTP id af79cd13be357-944217ee79amr3102793285a.70.1793892779627;
        Thu, 05 Nov 2026 07:32:59 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9378dc70sm28503746d6.37.2026.11.05.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:32:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:21 +0000
Subject: [PATCH RFC v3 89/90] MAINTAINERS: add an entry for cells
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-89-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=886;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=bxVFmIQz1A4OV16tOPOyHXBpf39eIIIpZCBMevyfB4w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFfaG6B9Qm9dwTtpKW0qrQ0wZCihBzNnqkbl7ieEgqy4UhVlxmWdPOoZon/zMuNEBXMWXEVK+uo
 PlLl/5v9RBQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add an entry for the new files.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc2c39eb417..faa9f1cc720c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6173,6 +6173,20 @@ F:	arch/powerpc/include/asm/spu*.h
 F:	arch/powerpc/include/uapi/asm/spu*.h
 F:	arch/powerpc/platforms/cell/
 
+CELLS
+M:	Josef Bacik <josef@toxicpanda.com>
+L:	linux-fsdevel@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/userspace-api/cells*.rst
+F:	fs/cellfs.c
+F:	include/linux/cell.h
+F:	include/linux/cell_ids.h
+F:	include/uapi/linux/cell.h
+F:	kernel/cell/
+F:	kernel/embryo.c
+F:	tools/testing/selftests/cell/
+
 CELLWISE CW2015 BATTERY DRIVER
 M:	Tobias Schrammm <t.schramm@manjaro.org>
 S:	Maintained

-- 
2.55.0

