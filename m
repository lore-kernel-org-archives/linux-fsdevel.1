Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714646;
	b=OOfZAJG5DIt2Sxx8PwKwnZVaRUjlAAHQYXs4qiSjQ5NCa5bV5n0xU7KrAzwpL5QKWDY0
	 FnEipGlDsF3E2B/vTBxeb+mw6kl6pRmOPiRPBNFncZw7zVsdCs5tn9eI/qJPTKgalf2NI
	 Is/uIoWqqRH3ssPB45zhlFgHFtogQkzcZu6rXFZjepfg9IMTUtclm8DmpVbz/mIpDdxzS
	 5j10rqgAq40Iu9+QZj8CVdjddlRCi8emCK2yblBvwUU3Pz0leCAWtFqiNY7Bge6PtvzNn
	 9ge5Y8koNUC8EsRQKyFXU4WFN15Bwyvcfi6E/uRJocYqgl/0olQg/+ZvWxNi5zioQIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oBYxcbD5svbaTalp54IT3TgPIj7U31fwSGEAMAykp6g=;
	b=Wpp8vKofHx06Bpoib2Q83rrON6wAQPUxnk5lMBsEZNFpllpeYt1ww/7qjjZUj7c7+2/E
	 0yxAuSuwOrlzuD85nmJ6qea2dLls6XqFmcuNN39HtnE0vAGTxhHq0sNj/N6cmZ21aSNO+
	 cDTEfOZMJzHecR71j0e55UodYJdK1HZIZq1MqP659qblY5vUNq0AXol47yYDOIsc5pcpV
	 zwOywbKjAj55boJfGXmWklP48QFzjKprTBrU4cEQx64FVWBnYDB+QqmoM90WFHV0ZnSMk
	 rfhu9VunRSrwSpJSPS6ZI/UOe8TpARcu3mzQ8iSVSnYRdaZdndH9FEhfq0WFl1yZGoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Uzdjs9XQ;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B8606A319
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 00:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C2B8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Uzdjs9XQ
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-156b5338d4bso34348c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714646; x=1793319446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBYxcbD5svbaTalp54IT3TgPIj7U31fwSGEAMAykp6g=;
        b=Uzdjs9XQVOgnkMzwfBYWvjzVPffgDZiQPHuB7ca4I04DBEfMxl+SZG2cJaTPfFOhwN
         t+g5y1oKjg1juaBKzo9njVVZJwP1DJtyBkRQhBQXvBsLQXvF6LgBncxC7JQJr0vDXhqi
         CP+7nNAOsooUIFkJ0iptaqUyOkBz2hNfRdjSz3rpEsqCnLeLg8kxvKWrxsIoAJdogkmB
         YPBpTk4CFBJKy6jXMT3L+7yw5RplJVA6nAlT+WJPWHicaHslH4es3yLeBG+O8C+XiPme
         h0pgfg4n0lRqt+1SwqQjKxolYOTGP0Wh3MRm5Hl8ntmbsGJ7Tz94WD2BVli+bR96kugY
         DEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714646; x=1793319446;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBYxcbD5svbaTalp54IT3TgPIj7U31fwSGEAMAykp6g=;
        b=RVkarAZQYfB6jSa8PK+lsBUZU0mRuw0D6h35ChOcK4KY58MWsetvfY15sZdKmRORXM
         684YMlk3ZDGWoCNBUSDd23laXY94rr19dZReOtzb+c7NBbbTFoQTQLIxHREqdnQDcaHS
         onvFv/FWbmORrmtKQ+jleEOI2B8WO2jwdPCCmQ7Mea58AHWrPrNrE7J93ADbYtJpxP4Q
         fq6XzXTooFUJKOE0d5IdvE5x6tBeO0V3PEnkoSMAkwUoWiF2T4MTXFwGzrCuTeMpV1jq
         a3k2to3bBlNRUoda8+9o8ZshOHMLeLpTUsAFsM4VscOYQLXyHwGYQOcNhnGXuUD6TyIN
         7zkA==
X-Forwarded-Encrypted: i=1; AKwUvBwHBPP/ipmuLx3jY+7UQ/+nKsglCMyr5VOJChYGgoXrVc9iWsRfQPwkmRPC/dbXsGbGvbJUfhvOgrNtrYa4@vger.kernel.org
X-Gm-Message-State: AFq9FYKh1eJxG9Kcxx0oxWsfrSlrrB9+GtA78AM417lbAnCHg0DHQnQH
	32yr/yShS0yeqwMm+Zrfc0aIYQ6BdYL/fOqajeBxyROYXHnswGTAc9zOWjN7CJt9hBA6ZjceyTE
	3nsivCq9KtVtyHg==
X-Received: from dlbps4.prod.google.com ([2002:a05:7023:884:b0:191:327b:5758])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4184:b0:16c:ff3a:d72e with SMTP id a92af1059eb24-195c6b29320mr1346079c88.20.1792714645130;
 Thu, 22 Oct 2026 17:17:25 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:03 -0700
In-Reply-To: <20261023001603.560210-8-wusamuel@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-10-wusamuel@google.com>
Subject: [PATCH bpf-next v2 2/6] tools: Copy KALLSYMS_QUERY definitions to linux/fs.h
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Copy the KALLSYMS_QUERY ioctl definitions from include/uapi/linux/fs.h
to tools/include/uapi/linux/fs.h for libbpf and the proc and bpf
selftests. Only the new definitions are copied; other differences
between the two headers are left alone.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/include/uapi/linux/fs.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index f0a26309b6d5..d224516e6d6e 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -567,4 +567,45 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+/* /proc/kallsyms ioctl */
+#define KALLSYMS_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 18, struct kallsyms_query)
+
+/* Exactly one query mode must be set in query_flags. */
+enum kallsyms_query_flags {
+	/*
+	 * Look up a symbol in vmlinux or loaded modules (vmlinux first; BPF
+	 * and ftrace symbols are not searched) by exact NUL-terminated name
+	 * at sym_name_addr and return sym_addr. sym_addr and sym_name_size
+	 * must be 0 on input.
+	 */
+	KALLSYMS_QUERY_BY_SYMBOL = 0x01,
+	/*
+	 * Look up the symbol covering sym_addr and write its NUL-terminated
+	 * name to the sym_name_addr buffer of sym_name_size bytes. The same
+	 * symbols as %pS are searched: vmlinux, loaded modules, BPF JIT
+	 * images, and freed module init functions still tracked by ftrace.
+	 * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes is
+	 * always enough. On success, sym_name_size is set to the number of
+	 * bytes written (including the terminating NUL).
+	 */
+	KALLSYMS_QUERY_BY_ADDR = 0x02,
+};
+
+/*
+ * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the name maps to
+ * more than one address, -ENAMETOOLONG if the name does not fit in
+ * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size bytes, and
+ * -EPERM if kallsyms addresses are hidden from the opener of /proc/kallsyms
+ * (e.g. kptr_restrict).
+ */
+struct kallsyms_query {
+	__u64 size;		/* in - struct size for compatibility */
+	__u64 query_flags;	/* in - query mode (enum kallsyms_query_flags) */
+	__u64 sym_name_addr;	/* in - address of symbol name buffer */
+	__u64 sym_addr;		/* out (BY_SYMBOL) / in (BY_ADDR) */
+	__u64 sym_name_size;	/* in/out - name buffer size / bytes written */
+};
+
+#define KALLSYMS_QUERY_SIZE_VER0	40 /* sizeof first published struct */
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.56.0.257.gf7497c7d27-goog

