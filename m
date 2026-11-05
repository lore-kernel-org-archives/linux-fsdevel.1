Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892128;
	b=GHtSBEX4PtfvQ/9Q/a0jGNOHKrqmcrIK+XT3PU/CdWqq4v7eJJi82zYmNoUhfT5/y5p/
	 IuhHeFcDIpEYDuYXADoe19ZeoImydTiP9IZesKPkH+4rwcMVr4TkApFiBJf2H9SLX7sD9
	 gaJARDCIVe9/4f3O/cJOK5IrYJv4Pc6kTBjeHS9xh+E3j/79d5eeHrBHdanFCK4nDwOEd
	 pzKIf1WVVGFifkyWRNEyQeqJTDhwR0cOSJMhWbPCneaFA0CBy8KQr7DGGVbK5B7YcXvFb
	 EmH2dB+L1bjB1ZLTq3rl1w5+dqY+XWYJLdwZZfs8VJKxVnPXK5pFiHb7ldl3VAPNcdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vj63xyhuZ3SVCbccahbLO+6+SjXllROfEnHLRARVSqI=;
	b=xFeFAMNFbbH+TpBIUKH15FfAeDWF9r5O95FMM3Kz/cUH6eMjfDVhtDec0lof1c1Fcp2V
	 luEkmALzzUUhcDfPQjF8mJp1iETOqOKw1XsEuMp+FDACKlU13T9kJdtQHGluFEhrEFTs5
	 WrsPAv/ZPSdAciWDjzJoFzPDNzkQ7+WpDOg9CFbd6YFDgItdFXMwmS5UOiQ/nUsr6Vhy7
	 4O/w3ZGpjRRE2L2bCrhL+/rmJEGmWDBRI6mmycrMruurj1k7QoilfMTIYFjY9ktGijnTl
	 54F5b/siPjeN66vMtskkBIta3YWhJKTLcsVtnstv9Y3YPuwuPx6S7LoIl223sBQppGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hk3vz+8R;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473F606A32F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9473F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hk3vz+8R
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f30660e69so149162685a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892126; x=1794496926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vj63xyhuZ3SVCbccahbLO+6+SjXllROfEnHLRARVSqI=;
        b=hk3vz+8RnfObq5Pv1ZZoHlBChlbX0ElAKLkc7I/F1uNaVSGwk04qb8mU8kkz9ae1B3
         ZHl4MP4vgohtkLAxxffdPymLme4JOws7ZMBkAwAeQiey51ZwbS/cjBgbbyGoCDircdKe
         /MfmY4IAj6RD8I5WliWVt6si3DxXCeejhuAkN0pDhN/yxRtDoeSxi/fgu8pcG8xtLmLW
         mq4mmI7OdLgsEf6CvjcfNLsUWf+xhFo+osTBsJQzpJaSz9lQqpR0jNW2ZmPpETggOgrh
         4i8vgNUpdzm2JS1pmvT29GPHlx9m4qxHmnaoPqg2odzy+D5TJhcOynVPM5H/DgE1/bqw
         GTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892126; x=1794496926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vj63xyhuZ3SVCbccahbLO+6+SjXllROfEnHLRARVSqI=;
        b=GSq2oK94SbzWHbRLqFjIXu/LNkEUllWT8e81ox88t8ZEnMneT+SteOoOhnFyXsjYh1
         IwArOpgQvhH1Rg44u9xQ/70ZATBqLhgH5NwS+RQLPlMXh18ArP17+Xuz0R+ALIOFl5Xe
         YjhsIRxxIe00PEFe+XOtzWqV9BFwfHMivKqEBRZ6nGi71paXHYhqfaaVgCE6EfnyXe0W
         RRzi8ziUw3HsLO59j7t5bqZO3YEa3x3OftMkuZz+s46ZJcLtT87AgNeYGcUx6bxD6U6a
         ntr3BmnusZOwkSLq963MXVJsBL1KMnoWyGSuRtxrXm3erx0wOZ/hwWAO5FewxmSpBEXx
         eH4g==
X-Gm-Message-State: APuU4Z8Cj+ZjJmcT3hEE5bz9z2tq0Uod9qzeijFVGjlnfI5zdr4bvujn
	NZSsUylYi+O0UVl8yJZvwXrorWCbkg13pUqT1g7sa5f3cw4juk+PB7jk3zSLJT9ITbc=
X-Gm-Gg: AYBFou33WFJLcWqscoldcVXY5RGC62WETZifrR6nvT1QoD8VY5oeCqtfGGr38PB9TlJ
	TO6uOz9xx1fQ3PjTne3cBwZRmB8tXopzoIdLh6rGaNgnx84BDdoDgghDYHaFX9OBicsCGCR2Ym/
	uMT9UBlRPQov5MdyXQq5EQUeY5lT8LIB9lhQnXribbjZTUUNA6XE23T0qq7+AdsQ2p3lofipDRR
	yRtxIp0slZXjhTMRJew7KVmGmMH27XF+w+Wy9eM4LoqzrcyIGMFzMx4dkjFAB4jQIvk8c9/XF9+
	eahUsSUJWP+WBqzYPcXsrOCLvsPLIgnIRSz++1bFYvopyATcjBXAVfm/dwkF6Ml/Lq7brBMc9ab
	teaeVoGad3Doceu8WEdpeMKnbnaTZu4FfPu6I659YjTrmpQVzzIdUlpvROKWJDhE2wPqHk/jfO6
	9cXJtmGVpHfDi1RC6ixs3KY5T5BFffdf1J7avMHdDJgp/GRhiRdzgPX5QbdgZD2eQf+9PHlwylF
	VbxLaXclBHnotTptBzeG5UvGMbvdws8qsw/jZix62OrKKImO/75P8d58vieJer+FoN0gFCsrv3V
	KZyAn2UHk1P45lcnOWTKeocdsLgIShLh1QmFu4fq9wN2Dg==
X-Received: by 2002:a05:620a:1d0a:b0:93b:fb3c:2d09 with SMTP id af79cd13be357-944217bfdc4mr3145520385a.66.1793892126628;
        Thu, 05 Nov 2026 07:22:06 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d47c6f5esm481020585a.16.2026.11.05.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:22:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:51 +0000
Subject: [PATCH RFC v3 59/90] ptrace: refuse PTRACE_TRACEME across cells
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
Message-Id: <20261105-b4-cells-v3-59-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=1373;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=00kMzkixkwO1y9l5s18VmaAqC40wDdqwsB124NYHwSQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QORpRdpq0dXNEhf4GcQiv93YcGkFIz6GZ2Kg7DN1VWvJrL/dYNQ/C0mMbGKkSbRqj/ymkuqjY9T
 s3DUVY4kjBw0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The parent of a task that was spawned into a cell is the spawner, which is
outside of the cell. PTRACE_TRACEME would turn the spawner into a tracer
without its consent.

A traced task is not reaped automatically. It would remain a zombie, and
zap_pid_ns_processes() would wait for it. A hostile cell could use that to
prevent itself from ever being reported dead.

Refuse PTRACE_TRACEME if the parent is not in the same cell.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/ptrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c30e15d39c41..c6115922ea2e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -508,8 +508,20 @@ static int ptrace_attach(struct task_struct *task, long request,
 static int ptrace_traceme(void)
 {
 	int ret = -EPERM;
+	bool same;
 
 	write_lock_irq(&tasklist_lock);
+	/*
+	 * The parent of a task that was spawned into a cell is outside of it,
+	 * never asked to be a tracer and will not behave like one.
+	 */
+	rcu_read_lock();
+	same = cell_same(current_cred(), __task_cred(current->real_parent));
+	rcu_read_unlock();
+	if (!same) {
+		write_unlock_irq(&tasklist_lock);
+		return -EPERM;
+	}
 	/* Are we already being traced? */
 	if (!current->ptrace) {
 		ret = security_ptrace_traceme(current->parent);

-- 
2.55.0

