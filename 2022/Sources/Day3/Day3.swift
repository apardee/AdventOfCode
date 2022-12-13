@main
public struct Day3 {
    
//    private static let input = """
//        vJrwpWtwJgWrhcsFMMfFFhFp
//        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
//        PmmdzqPrVvPwwTWBwg
//        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
//        ttgJtRGJQctTZtZT
//        CrZsJsPPZsGzwwsLwLmpwMDw
//        """
    
    private static let input = """
        WjmsdnddnmQPZPPJPL
        bQllTtpBlgwtrbbCwfZcfSFPSfLCSF
        GgVgQrlpphBGrlVGgTtsRHRWVRMzRdVsqdnDnV
        MMTcbpnfNGQbMjgsRwSzRptRzz
        lPqCCqQdQqQmCPRzRVSwtzgqqwqR
        lrDdllPdBWdDFQFnMbDNDn
        FldWTldlpBSLzvpnpSTpWbDhbHNDPHhJcNHNDwbH
        qVCGQRGrrgMQrJhPNchgvgJhNc
        frjGfMrGQMjsRrRQjvQGmrQQszTTpSLBznlzBlLLSBLLSZTn
        TPZZZMTTbNTZNtTlTbjPVRVGzpGQLLzdGgmslhzSzgLzQh
        wrfwDDvcnFvCfrrSQsmzGGQQdndsGg
        qfHwHCqCqCrFJrcBHCCJRmWTRTmVMttjRjRHZMNV
        vpbqnzbPmWLFjFLBnjZg
        NltQcCClQlcGQGtMTCRdGTGBFZRLZjFFZZhBPLrFHZFjHf
        lMtlGMwMsCCNlTwtsCPzzmPmmVpmpWqVWsWz
        VmWVSchSrScGtwlVtBnwBVFF
        RZZPRNpPCLZvZPZNCLbQPZNBFtttmwBMTMTtttCwtgwBgl
        RNNmPvbQQjPRQQNNHpNbhsfzWJqqSJcsGHhHcfhq
        dtJvcpccWvLDztRCRRCrCC
        qHVslPzPqHqzmPhTzmDFggjrHrSCNFFFSjgR
        qPVPMhszZPVhwBZcdpvZJncbcJ
        HBNLlBDtvLDHhHLvfwlFjqfQTFqqWfST
        ddsGcggJncZVRdGCdZdcWWzSFrjzQFrfTzqfCjFw
        VdgscZmbZNBvbDHTbL
        GtSZQqpHpHfGHzzqHzHfSbPbnJCrRCnJChmjnJnbSh
        DvcTNTDWlNDWdlbnnbjmRhRrCCRd
        cclNlwBRvvTNccRlBNRspVLLZzVzVZQqfqqLpzpw
        dBSfHdZvMQMdNVpWRmWmLCmmtB
        rbTTrrjDcqcrrqrjjJGGclltPCWDmvtpmpPpvRDsCspsLC
        vlhjThlqcjrnTvThndddHZngMnfwNQFNFM
        tHqfszrgLsvgqtHrHtwVCGBRRjGSCwsCsmmV
        MdFMclPmcDQFDlDdlZPmbVpCbFpCbBSCCRGCFpbV
        mcDJdDQMcDTZQhhNNPldhhDtvHLgqtzgLvzTzWHWnWfvvz
        sVdGlTMMVTGCdsTMHHWWnNBzNWpNWCpW
        mPmjFhlwmwmWrpSrSWHB
        jhPhjwgthtFFjRwjZgjGdJcdflfqMsZLLsdZdc
        CBRsTsBBzLCfLqtqBRPNDQglSttlcgDlgGGt
        rJdbrJjrdbVJZdVZCGrNNcgDQlcQrggl
        FpFbbppjFCdwmTvsvfzmTnTBfq
        cqhcWqqCNjGWqcqhGGZzngftmptLZLGZTn
        brJHBbPVHPvSsdHrzQLzZgpfVzpfQtnL
        dHFPBPrBJFRzcWNFhWwN
        QTBTfQTZsjWDJBJd
        FgFWNqWGDPqlPllp
        CCvHzSWFrrtvNvNNHLGQQfbVRRfHZcZcVTTTnZ
        ZCCHHCVRZzBZQThM
        nljDtcqnhcfbwjwltfLQMLLQQppJBMLQJL
        qDsqschsqblDqjcqtRmNVVdNsddNNPmFgV
        QQRnqGBSpQnMmSGmRQQFtdcbbtHHccjpTFcTfF
        wCNPNwNNWNgZHJHJFffqCjbj
        ZNPzNWgNrsmzMVqsqs
        pVWlMBWjlWWqspWDjdjMpMDCPtmmdbhtQtQtbGPCzChchz
        HZNgrHSvHwnFZnvgNvnwLPBGQHmCmtPmtBCGGCmQhG
        FrNfvSNSZLZJrJsVlRWWWqRBVTff
        PQctSHQDPSQcbShpFzbmFddpmdmR
        wqWVwvwNCJRhmdhwJw
        nMnWggVqRVZqHBSBsQsQGDSZ
        qppwrgZSLsVbbfvZ
        hhBHPQQChCDcPcsvvhbGbsllJTfv
        MDWmWFCPFWtgpRWjws
        bmRjdmrJRjhJdJLZBjTFfHGTtQFTSQBS
        wCNVnsspwsnvNDwnsDwSBHtDHHQGTFQFtMrQMS
        nWsNvqVgVcqdJrchrz
        MZlfqlmblmMRWhWNsjSQfh
        CznczgtDFnVtFBNSRNttvhQsNh
        SGDFzVrzVPrGHVnzCPVnlZlPwTbpTqlbqLMpbLlq
        lbbbGDlwLDLjvDvm
        FQfQnLTWVcPChtjmjWSj
        cfgzzgfgfVdzTdfNwBpbLbwdRbpZGrdw
        mwnWtbmdWdccwtgTmwnQfPqsqLQQJQQLsfQQ
        SjrZbhvBZzPHQqfGJfjG
        FlrMBSvMZZFBZhShMMdctWDtmFNDbDTmtmpt
        ndHWprpqFTnnpdNFlhljzlGTwDGzlhGz
        fvZmmVVfJctMZsgMgmcBmsZhwQlGDCzPPZWDGDjCllhC
        WsmvmsmRNnpRHdbS
        LgZSvhvcsWtcWnjrFrWjjjnPWW
        DJDfNlDNRFlpMlFLFP
        TmqTqDHdmfwJRwfdQJLHzzSggHZZcGzhtZvcZhzG
        lbTpqhhgSlgtlTqSDzzLPPPrLGTTGnLm
        VwGfQGBGZWNnmDLPznLB
        vQdfZFWvFMMFwWGGhpGqJbpFtgbS
        hSvCvFRDwmzCCHrszb
        jdMgfTblgjJTLLLzqqGscmPmlqPzHc
        bjQLTTbZMfJffZBBWdjBBQwVDntFpRvvDVvSnhppFv
        FFnFQndPqzmjHscmJFwc
        ZrZrRgDphGGDZgRRBSBNMHHvmwJJSNJHcv
        DGrbbthfWWWDgtfffttfpGPVqnmblqPqCdQTlTPCzTll
        sHTsGrHpsftmddRRZfRv
        MqFcqcMQbMcVPCdFZCzZsRsFzL
        qnVlBbcJJbbMcbgQJMMbQlDWWwHWSWwpTsGHGrpDWG
        qpmvVVcGvVVcVmDsCfqTHLLJzTjfZzLZ
        rSSgwwnSRRBrQrZzZHCQrZ
        BFgFRgdNnSBbbnhSMBSNFdsWVtpWmzsGtvpVPvGWVDDN
        fBBRfJBzzMRGRzCBgWtbCWtbgHHHWdqt
        mvNcDcsDLLnnqfbv
        hpTsTsTrDrfpMSFFZjPFMrSP
        CNQGGDMFWGnWWvvNMQFPvrgzBLVBLszwgggLgw
        mppZVZtZRTbTTpRccVbgrSLzSPSzBrfbPBbSPw
        VtZJhRJcTpJTHlhtHZCFFWFjNjGGnFhCqDqG
        cppcZGcGgGpdTgSSnmpFMFrFzmwqwmrHwz
        RStQJNCNvfBQNjrqmrjFrBMzFB
        LJDNNJCDLcdLnSVd
        gNrBNSrNNtSjBndzmzlVnm
        MbfqfpCLpCsLqsLFSbQLfnMdcdRRcdzldlnljzncnJ
        QPQLqZqhSqhvtvTTWrNg
        DtrrcGvtLnrrvLrfctfHztrfQpbwwphpdSbbPPPwFSFFRPwH
        gggBqTNdTNjqWBlNmCqCmNggQPhpPPPbhhQpSBpJwbSJSQFR
        ZglTmgWNgVZMZdsGMcvDcMdMnz
        bjtTFsPmmtpvVlQHlQJQnJjn
        WzDzwLCSLrrDNLdrSZRCwNzrlQlJMnJQJJVhbcMhgllwnJQh
        fRCZzrWRzzGbGvTmBPTf
        lVlfJVblPQbllflfLdJdvGpjnFRFqJFnDqpJjnpF
        HcwZMgmwWCHHCSwcWCcgSCtCqqpFppGDqvDnRhgnnqFDpjFT
        cwCHtGrCssWHCCWZZMbPPNBVbNfVbPllVszf
        DSpSnRwrZDPWsJdZ
        zjjlQVjlNZmCVCfhCfgFFfFFFqWJbgbFWHJH
        lNQMlGjQBZjCmhNMCChGzlVNrpTnccLLwcRwTSppSpprLRcB
        vLfvcgglbfLfgqdgNpPtzqDmPzmJTTztPCHT
        ZWSQVGwQcWjSshGwVcnSzDJZtPPTzmzzJHCTzDtJ
        SjVSrWVhQVQhwrLMcrFbfplcflvv
        NgtfSRPnnRrSlgsPhnShDWQlMWpVBMMMpCWVBpCQBB
        LLJnvwJvZHZbHTbVCQBppCFJCWWQBz
        wHTGZmZvdvLvjLwZdqngNgsGtrDPSDhtNfDf
        DwrDRlrwmbSbRgwsSbRwGJvQGqjJqGNTJTNGTSGn
        PZdMZzCQFBZWWFQvJZvcNcjqNjjZJG
        WHWCFHBBdzzMWhPFtFdMzlRsVbVmDrRVVrtQplwVwD
        bpWbJMWpJbprfNMrBfJfprWhPnGtnHnLHjPPjLvsWnHGvGvj
        qZdgVVgDQhQZlwcqgDcchldjjmLtntmntPQsmLnLPjssnL
        RVRlgcSSdglZczdqbTCrhBrBpNBSBSbF
        SgbGvfbnGgmnNnnzqMqqHHRzbZBzZR
        TWlssdFwWdtswWPtTtWltwdVHlZZzRHZBZRzrprqHMpqgZrq
        dssdCWTFwSvgmDjDCG
        pqsDnNzzZsdZSnDSpwjBCBWvgjvWjNFWQgWC
        lVGtRtLMGGfbTGTtTbQCQnBQBnBFgFQcgjfc
        GPbTbPtnPttmLTGRRbtmdwSDwpwwhZqmdpzDhDJd
        MdccRQMJvHdgZggvhjjMgHcHlWWqFFWmGqFbJWzzFLWlLmPm
        TDpSsTrtblSzQlGQ
        tfVNrwTwtswTssMRjMMQQddNMRCd
        GqGqGpFqqgDGFRqDwwqqmzpGTLPvVWMPVCPLJLRJJMLTlCWV
        rHrSbrsbQcbtdNHHHfdPlvWBLLWlvMTVlVLCJf
        rccbtthHSHsNHrrcttwqpnDFnMmpnzFnFhnF
        vQQQbRvlLjNNLLBzNllNHNBqGqhMWhGGhTqmPmqhWTFhRm
        tnsZwgSnCDrZSCDsfTMSGpPWmPSWmGmbFq
        CrVnfnCCtrCgfrffcrstDnJNlvJdNvzdBcHdLBJHvbBv
        nmQsMqTnLlmmpQZmTZcdHwCFSpHJSSWHSJVSWSHH
        vRgRRtfPvDjzDgDbsjzRvjfNNWWCSJFwrHCFbrCJWJHCSC
        GhsRBztDBgzRPstgzBLZcqmlcLMMlmdLQBZT
        CWfvvhfWrlllSSRrdQrQDQGQdTRr
        jsNctMZLmMZLMmmmbbNZswZNqBTHPHzBMHHTMGqBRMRPDQqP
        jcwjntLngngplgFhgRvJVp
        vchzqzwlhzRqzVZQwqtVPZLnLLbDnDFnbGLnDbPLDGWD
        pBTHpdpHsrNBBsgdrdCpCpCgRFCMFDLFWWnFWLRRGWbDFGSF
        prsBHfggjpjjcRQlqvtw
        VDwzLQrDDWrrwWbJrVJwVrVQfMfSCNPMfSlMlPcMmThChf
        tsjFdsRsgtRmGZHpHRgBClSlGSClcPhGCfPlllll
        qBBFBZZpmgdFHdstjFJbzVwJVqJWWbrvWJDL
        mgjZmrqmdsmGtDplglJgRVVc
        nPhnLvnHLtLnWzzcNwwcchVJRflhpc
        SnnLntLWZsMqZrSZ
        jcrNfnrNLNNqFgbDfCSgSQbS
        zPPHtMrGGptvTWPVvzvHRgQsbDsSRRCCQbtJsJDS
        wHzrWVzPwThGGwMHzTGGPGwhdlZnBndZLljNjBcLdZdNBN
        qNPhNqddBNhqvPhFvllNgNBHCrrCQnjpCfPVJnnJQJCjJj
        ZZbZTZcmGWWMDWRSDnBVQCjVDffJjnnVCJ
        SGBRTTZGGcLSSWTScsmcMbGlhgwFqslhzqggghwhNvwwvw
        GCCPwpsBqNSsBPpSCrSshzQzLhTvQhqTnhtTVQcT
        JDjFJfMJgWbWWlDJcnvvhvtdLnjnzhjz
        FlDflbZfZgJgMgbmgZJfSpGCvvrGrRCpCBrZRprw
        HwqhgFGSMgPPCGQQQnvvcpjn
        BllbdfRBsBmsmZlBTmQCjTnNWNCmNmvc
        lJDlBflDdbbRlLbfsbZBJtbRqrVFPnwwwhVMHwVrgJwwrSwH
        LTvLtTFLCddFTTthsbVVmHHcqVHmWRcmHL
        lBgwwNggwMwNVbjBCQcCqCRB
        nCMCwZGGNGJnGhtrzsdDDndtsF
        ZlZdJJplLZBDpJjNJlGjQCLmCQmTwVVCbQQbqWCT
        SfgFzftrnRzMnVbPPPQmPq
        FfmrRvgShchvFfghzRvgtvFBpJDpcGNGdBHJlpDDDJlDJZ
        LdNrLzjdWQnrDHsD
        tBZmBZtVZpldVMPRnsRQsnnsHVbRHs
        MlfldwMBBFMZTSFTSqLqcvSJ
        nJqBlvvBjHhBcqqRrGPrTrGpBCGzTG
        MfVCVMLZVZtQCdtLMtQtQSSSTSzFRSRPFpFRGpdTFd
        CCQQtQVgfbbQNggsNfQZZbHbcWmnhlhnvlnlHjJWvnhv
        SGmmGwVwnmhbhnhwhhwbdMgNNgjmvMDrJTCgmBTBBj
        ztFWcWQQfcRzzRFllvjDjggjDDfBgJMBgC
        QtzcJtFtqcFQRRWRRQWFzFGpVnVSGLLGZVGVqddbLqGL
        tBmdmQtjMMqDLqBtttQMjDdwwgwccMMbffllgzncwfFflF
        TPVHTVsRsJVHVrVvHvrRhVJbfCgFbzwbCGgFlwgcCwbn
        hssVWnRrTVZSSZZqjLddWtLBddqtQL
        WhhtGZtZGQZmvCfCwtvhqgbfdDJdfjlSDlSlBBJDSg
        rHnpFHnDrdBggJngnL
        HVcTzFPNzTpPPVrzmtwtvvvmNQwDQvWw
        dStBwStGGBrNnBdrSSMzvjhgFcvvDcnnvPDn
        RLZbCWWJbHRsTHspZWLcDWcPPhzczfjgPjjvjz
        ZmLHJqJsLJJHLRsmmmGSztQdQzmNBrBN
        JrmRVdvcmvvmvvRTdBVVfjFQLwjqLFLWFMqwcFjz
        DDhhttDHHHbHSnsDbHqMqzwQLLFwLsjjLLQf
        bSbPthtgGQPNPHnSDChCRJZZJRCZdCrCBZZZZvJd
        rqvVqNJpVVNwnqqTwthMMq
        jsFRFDQRLQDQmsPRmQsmcQFMzGhwBGBhTzTTzHnRhnhBhRwz
        dCccQcQsFCmCQfbJbvZMNZfJrJll
        TGjrrTRLHvrQrFDCrmzzVm
        NwWqqhndWtzDQhCzVCsh
        CSSwNNwqgBBBBbGGvLTTvb
        fRBRBHCVRRzcCdZHvRvZVCZLNjtwtNwNTtLjNtTpTNttfS
        DZshMssZmTMjwjSLtw
        QPrJDDJsPDFmFrFDscHHRzrcvccCZRVzrR
        zgqzLLvlvdgpgrWpWW
        RnJmNRncnScFmZSScrJQQdbpGdHbWHtPHpBHsdFdsW
        JDfRcrSnmDSJcNfrNZNjvlwjhllhMzlDqMqMvh
        fDLzSMLhhtDWMvtjCRRZjCHHJjChHN
        pmTNpVwPNbPwPBFRqRJqjCnFjZFV
        dTwpddsTbgbQBssprsgtvgcNLzWMctfSgcfWLt
        fbBsBTsNDhGBGZcLLLJJQffQLQ
        MpsCCMHClsHQqZcQWLqR
        FtjdCFzVljFlslVCpFrFjPhggBGDgNSTTgbGNmbGTr
        HqTfmsCFmPlGHddNVGpLhz
        JjjcQQJgjZvZZzzwgpNVGwLGgV
        nQnSbDDRbSQJQQpRZtZcZZsPPrFfWCPFWlrFsFPqmqFt
        TgTDDrCmqJDGLrhqLmLGqDQRFtttjMbQZJjtdtjFdsdF
        WHffcHWnlvvcSSWzPVvHpWWVRbFdQQtQnjwZFMwZtwddsZbd
        cBpPplVVPfvVGBDLGCBqmmLM
        dlMMmnmjvCCjJrrvMdgHcbcFbqFbzQrFbGzb
        tPhRBRZPtZRshTzRsNShRZNGDfGgFFbFQqbGHDHbqfGD
        TSPhBVsTwRBTpVtRZpVhZLJjWzLjJlJlJvmwWWzwWn
        WcvLLgLcczLTDtccbLcgzMMfPsGwRPjwfMwHMfMvMp
        QVmlPQCdJlJJJlFJJJnPQQhlwwMMMnMwNMpwMGwwfswwGMsR
        lrSCZZVFhPSZgzgWttWBcc
        bwbbZLlbwlJhBzFCgtTGRGQldQRmQW
        SSnpHnPHqpmggCWgdT
        PPscHHTfcsPSDVfVssjvwFJLBJFjFJJZFJLNLwrL
        nLgDSHgwRgGnHjjNfTRhjPVpWV
        BstQsvhQZQQbMvCvMPVNWpPcTjfmPmmW
        brtCrtvtzrhdSDJDwh
        dTQTwgmZQbDzzMQCCl
        WLLtntFnfnRHbttnSRRzSMVGDDMGzVlV
        JsPhFtfbLWnsLPLqgdJcjmcwTwjcdw
        wMwMbMRRBBMLPBlhLRQlhPcWzgJNvJtzWNtJptpgjJgpBj
        TnmGGmVnFFNSZsnZqFsWzWjrTJzvzWvWgWtTWz
        qnHGnVSsqZCddnGCGCSNdDbLQPcLLQlDhPRMhb
        NGsBTBlqsvfQBQqsTLTFltRMmRwmmHmFtPSRhM
        gjZWJWCZdDpjggDdgnpWdZZJtFwFRFFRMwbbmRPtShnwRbtt
        zZpSDDgpzcDddjVWggJsQGrfQvrQcTGTGrTrqr
        hpJchhFWMpRDWHWcDGnCGrnGnwPTwpQnCt
        bmgddgmlmjjbfddgmmmNvGQLrtfTwrTtLtGTLQVQQP
        qqbmdZgzZbvgPDccHcZPhWWH
        VVrdQZZrZSZFgQTTTzggrVZVMlfBBfvcMBCBslMhBvsMBSff
        bQwnHwbNpwcsCwjMBw
        pHqqPnJHqpPNJFzqTzQWWDQQZq
        HgwTDfgBwBgcRHqRRjHqHTzQQClSzvlzPVSQLvbbPC
        MnhtNZNnJpWpGhMQbCCPVSPLNmSPQQ
        rrhJMFJJZFJpHcjRLFRfHjgj
        vGvGMBlttBltvjdgbPsrsDWdjPPP
        HnJQHVqNmQHmZsDZPPrDWpgFps
        JSqJQVVDqqVfJNfRffGSGMBwGTCCCTlBMSBl
        PsFZPfGbDNbtQmCCmCBBbmmL
        dcRdhSrCqjThTRcTpLzHQzTmpmlgBz
        hhhcqCvwhhVhfPNvsMstZtsZ
        VvGwBBwvZtGgfZCqShnFFjSstCMC
        NlTRdvpDdTRNzdTHHnMssCnCnCqjSz
        LvWvPcWLpGwBwVVgVc
        bVVmSrLmLSJzTZMSFTBdMj
        QnvqRGGDvWpQWGDpvsRZLBzTRjBTtjRTPtBF
        QWGvDpqcvpGWQpGngqGQGwpLhJVNJcrbfrVbfbhHrmlVJHVV
        NGRGPZWZpblGcJtfssSSsbffCs
        gwRhjvrgjmwgnzvJJJtVCtHJqs
        rrmLrhwFFmmTMgFRjNZWNpZlZLppQNcDWP
        qsHZsHZrTBtZrHBNFCJGWrMcpcddWGJWLG
        mRDDzbPVDVlVDgbgRRvmwCcWdGvJwGddpvLm
        PnfDbPbVzDbVfjnnlbzhVFsspBSfFsssHQNTBpFqNQ
        gCmtbDqPVVVqggCGqTJjHMpMQfgMpMHQQpcM
        zNZnsSLzZzrlRhTTJMHppjfHSpvp
        nhdrBsLlRRrdTlsTVmCmGqDVFdtDPGwV
        FnqNfdGfgzmPLGmj
        blvVvbsRwgnzjCPcbT
        RWWvtvphnZQZwMBNdHfNDBZZdq
        DMRhDhdvnjhnPnvPMfdZSGTccGJFjGFFpFpFTbTpTW
        NVgVmtzVlLBmgztsBNmtgCmqFpJJFGGpGbrcGGsrcpbWPr
        zwBztLBzllQPDZvfQZfRfHSR
        mFCgPzmqgtPPqMmFWzbMttcRGvRclvHhWGGcZvclRfHh
        psSNnhnLGnwZHZGv
        hBpNLTNLBhsPmbCgBtPDbM
        JsbLLWLJRfQFnccmQhtvvPCP
        dwgrVwGpgVhCrrhPDHtC
        gpGSjpVdVpVppjjVZBwdCbFRWLzLMSRMbNzfzbWR
        DmMQMJmnmGwzGwwG
        ZcLcgLgcRsZSctHFWLGfjjBwvbvBsvjpfhGb
        GgFPqFtLRHLFSHLRRFRHHtMnJVNCQCrJCJCnMJDdnqDV
        tqdqFqdsRdVdtHMNdRZHTZLrHJgrlZQPJLgr
        GGwVcpGznmhbWhwcVVgzTrDrDDLZlTLLZQrJ
        nhbnbfjcnfMfFNVtBq
        QHmPNZvfCLsSwJSm
        pDhjpVDFcRBpFFjjMnRcVhpFCzbzsZbSSCtwtLMSLZLLtLbs
        FRjrnRchnfHPrrZlHl
        bjjMbdChgRDZthpQpRQnwRTprRwS
        mGzJsGsHzHGPvvvqvzGzSnglSJrrwQgnlQQSrlQl
        qvzHqHLHmHgPsNBdCdZtVBtVVMBFbh
        CctrCwrdpTwcpVrdpTpcrcnSJQttvQPHJQNQnQNjvvHQ
        zsqRlslRLqfgRmWsRgRzqzQnHjSBSQWJHPhHnSvHnJJJ
        GRgllbgfRgbzfRmwwcGdFMcTVPrFCF
        """
    
    public static func main() {
        solvePart1()
        solvePart2()
    }
    
    private static func solvePart1() {
        // Sets of characters on each line, separated into 2 half compartments.
        let sackCompartments = input.split(separator: "\n")
            .map {
                let source = Array($0)
                let length = source.count
                let first = Set(source[0..<length/2])
                let second = Set(source[length/2..<length])
                return ( first, second )
            }
        
        // Find intersecting characters between compartments and convert to scores.
        let total = sackCompartments
            .map { (first, second) in
                first.intersection(second)
            }
            .flatMap { overlaps in
                overlaps
                    .map { $0.score }
            }
            .reduce(0) { $0 + $1 }
        
        print("total: \(total)")
    }
    
    private static func solvePart2() {
        
        let sacks = input.split(separator: "\n")
            .map { Set($0) }
        
        var total = 0
        for i in 0..<sacks.count / 3 {
            let first = sacks[i * 3]
            let second = sacks[i * 3 + 1]
            let third = sacks[i * 3 + 2]
            
            let shared = first
                .intersection(second)
                .intersection(third)
            
            total += shared.first!.score
        }
        print("shared: \(total)")
    }
}

extension Character {
    
    var score: Int {
        switch self {
            case "a"..."z":
                return Int(self.asciiValue! - Character("a").asciiValue!) + 1
            case "A"..."Z":
                return Int(self.asciiValue! - Character("A").asciiValue!) + 27
            default:
                return 0
        }
    }
}
