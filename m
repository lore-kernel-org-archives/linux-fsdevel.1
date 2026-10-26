Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051570;
	b=YNs2nIDbthmp4qfZbVYXqkrdBpiN5s3vU2G1OMtHyoGyOqSn9IyHzdYl6B4fIOteX+3n
	 INW3xlwrvLws9bxPdqCsZLJDWo/++XJaeTFzdyHUf7JryFBj3EnbxXhe76lneHLdBug7x
	 F5RMuaWvjP79WPlmBrgWktCILWHd2L5Ah/1D4C5Q/XcBVk8NjU0b++EFzXReAxDuJKnKF
	 BCC7vefXeiJqbwdxEZJqRsvkHR3W3Am6hTG71Isc8pBavClyp+iQIpRPIT6qQD+7ZYN84
	 o40MKh9/dDjUeRki9/3zJHrTUxdTYTxnfIo3S+nKJoOmXZ75UcUfkNw3Vx/FaKeWunQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RD5MWqHEB8iYDLFdQXvkJ0xSc6fsoJ0ZXufXHQQ7zgM=;
	b=QLC3bdv5dR0D4kEsxuVVRWKd67Ch+A3PGaxt2nHxsyr/37oHldEvNSc+gsSi15yc7sbp
	 ArQ16CUVS/+Qs1b/9lhM0ne1D1FJwAVYysY3kfK/0yfpFe+lGKp89JtoWM5wWvPoU0b76
	 6cmX1iATbrj26pIIHoylMmMv/HBk4ooeygEtGsvoI3qLnRV8qNDdPdHTNBPVJbp+F/G/y
	 M4lrqrMVMK/JUu37IRGw9nN/gYRMvmABV7EvFYTqSYdb4+FCxUXlhnegDJBrCiejEvuTu
	 GrZlMoggL5cJoObRj2Pqghlb96t1ij4qgZ2eoeivwZWITDh/V/+oTrnQ5N3kf0rCKCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ttuByBgZ;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF8606A330
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DF8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ttuByBgZ
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd6532dbd7bso2041566a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051569; x=1793656369; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RD5MWqHEB8iYDLFdQXvkJ0xSc6fsoJ0ZXufXHQQ7zgM=;
        b=ttuByBgZyXhz+vCIDU5aBy90hRWqwioXsk1DTyafweNnvz2VRwJpnWhZTDjU/ruhRF
         +eNkpq2S/OLTAC4WKDyiSOVdOZpoaInxvu9UjK8OVtqVOVGoXQz0xw4USi3sYBtAAjKW
         xFkNF7RtNx3C8ylvzrtr3yIDJFmQr5Fpx5GMG7lg7Zxkb9Zz76slRyBARq30C4fj/GZc
         lewXB4OZG8GXpxXvg/Z2Si+lR9m0f1WY60ZFwIRoGIQ8gBxO4HkEYP6M2T1bDHZOH6bh
         LsWrGaMFI/TsCQGQozWRU1Jk+J5GWR7q6ZBrNLB6qEnTv5RGoUe2N/rfxG8p6ofbEptr
         6CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051569; x=1793656369;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RD5MWqHEB8iYDLFdQXvkJ0xSc6fsoJ0ZXufXHQQ7zgM=;
        b=nh02oSadW10l76RnbxlN4MqSbS/sRG4dd5m3Z1jV5NY5VTHIvSQn8V3xdxiUQyMidP
         cZuDusNHU31HN6Nz+FtebnIB9uYHjNMRwgf7v02iPukMuyf60RgDp4mgmpWY2yNwQcqa
         PI0ef6HDJxt66crW/X0xk/B1pwsieV36vGrd/N2IM5razoa02m41SlVGjO2n1wk+KGEA
         TS2Crm1ENAIiu6iCDXDqMqXheTVDS4p6Z5/aYjfu6/JZgMB1HNS17szwEyt5LZ2H1wLX
         IGSUS5ETMfKlhM8xbvISSM9eene2xZA9/IZucO/LA3kjQImLkykV7f7x5fgKpwnRmbGV
         wwdw==
X-Forwarded-Encrypted: i=1; AKwUvBxp4rL+n4QmlsWskG5sh/YKtmGnbHonuXiu46dnrWjGxKjk1wPgcNN4jM3Sdkb9JN9APrWm02NUAqidoD9f@vger.kernel.org
X-Gm-Message-State: AFq9FYJu99sn7vKsZRTJec3Ii+zPshU9grHqwI5FMtB2WppnJKJRk8+P
	00I+EPgGSVzHwvFOuT46ifm6EsnaEC0EpxepFcoPwSvDqy+ZK3DkXaircBvnw+Vcc7NqkpZIfpC
	WD+Ptc0wgN8c/WnhSw9KULA==
X-Received: from pjps6.prod.google.com ([2002:a17:90a:a106:b0:3ad:c8d8:70c3])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2688:b0:3a8:cb54:e135 with SMTP id 98e67ed59e1d1-3adea899125mr6172313a91.19.1793051568668;
 Mon, 26 Oct 2026 14:52:48 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:17 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-2-jthoughton@google.com>
Subject: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

scsi_bsg_uring_task_cb() copies the sense data to the submitter's
response_addr with copy_to_user(). It runs as io_uring task work, but
io_uring may also run it with tw.cancel set from other contexts when the
submitting task can't run it: from a kworker when the submitting task
has exited (io_tctx_fallback_work()), or from io_cancel_local_task_work()
when a DEFER_TASKRUN ring is torn down.

In a kworker, current->mm is NULL, and the copy does not reliably fail:
the user half of the address space belongs to whatever mm happens to be
lazily loaded, if any, so up to max_response_len bytes of sense data may
be written into an unrelated process.

Don't copy the sense data when the task work is canceled, and complete
the command with -ECANCELED.

Fixes: 7b6d3255e7f8 ("scsi: bsg: add io_uring passthrough handler")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 drivers/scsi/scsi_bsg.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 5eec248a77a6..3755e33fcdd2 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -43,9 +43,17 @@ static void scsi_bsg_uring_task_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
 
+	/*
+	 * If the request is being canceled, e.g. because the submitting task
+	 * has exited, this may run from a kworker or in a different task, so
+	 * don't copy the sense data to the submitter's address.
+	 */
+	if (unlikely(tw.cancel))
+		ret = -ECANCELED;
+
 	if (scsi_status_is_check_condition(scmd->result)) {
 		driver_status = DRIVER_SENSE;
-		if (pdu->response_addr)
+		if (pdu->response_addr && !tw.cancel)
 			sense_len_wr = min_t(unsigned int, pdu->max_response_len,
 					     scmd->sense_len);
 	}
-- 
2.56.0.307.g5fe7bd680c-goog

